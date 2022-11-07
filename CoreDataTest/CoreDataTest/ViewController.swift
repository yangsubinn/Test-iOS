//
//  ViewController.swift
//  CoreDataTest
//
//  Created by 양수빈 on 2022/11/04.
//

import UIKit

import CoreData

class ViewController: UIViewController {
    var container: NSPersistentContainer!
    var resultList: [PhoneBook] = []
    
    // 2. VC에서 생성한 persistentContainter을 가져옴
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var phoneTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        // 2. VC에서 생성한 persistentContainter을 가져옴
        self.container = appDelegate.persistentContainer
        
        fetchContact()
        registerTableView()
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        createContact()
        phoneTableView.reloadData()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
    }
    
    func fetchContact() {
        do {
            let contact = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
            resultList.removeAll()
            contact.forEach {
                resultList.append($0)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createContact() {
        // 3. entity 가져옴
        let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext)
        
        // 4. NSManagedObject 생성
        let person = NSManagedObject(entity: entity!, insertInto: self.container.viewContext)
        person.setValue("오잉", forKey: "memo")
        person.setValue("김아무개", forKey: "personName")
        person.setValue("010-1111-2222", forKey: "phoneNumber")
        
        do {
            try self.container.viewContext.save()
            fetchContact()
        } catch {
            print(error.localizedDescription)
        }
    }

    func registerTableView() {
        phoneTableView.register(UINib(nibName: "PhoneTVC", bundle: nil), forCellReuseIdentifier: "PhoneTVC")
        phoneTableView.delegate = self
        phoneTableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = phoneTableView.dequeueReusableCell(withIdentifier: "PhoneTVC", for: indexPath) as? PhoneTVC else { return UITableViewCell() }
        let result = resultList[indexPath.item]
        cell.initCell(name: result.personName ?? "-", memo: result.memo ?? "-", phone: result.phoneNumber ?? "-")
        return cell
    }
}

