//
//  NewsVC.swift
//  Test-MVVM
//
//  Created by 양수빈 on 2021/11/19.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: ArticleListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e9b514c39c5f456db8ed4ecb693b0040")!
        ArticleService().getArticles(url: url) { articles in
            
            if let articles = articles {
                self.viewModel = ArticleListViewModel(articles: articles)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTVC", for: indexPath) as? NewsTVC
        else {fatalError("no matched articleTableViewCell identifier")}
        
        let articleVM = self.viewModel.articleAtIndex(indexPath.row)
        cell.descriptionLabel?.text = articleVM.description
        cell.titleLabel?.text = articleVM.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel == nil ? 0 : self.viewModel.numberOfSections
    }
}
