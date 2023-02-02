//
//  TableVC.swift
//  HeaderDiffableDataSource
//
//  Created by 양수빈 on 2023/02/02.
//

import UIKit
import SnapKit

class TableVC: UIViewController {
    
    private var homeData: [Memo] = [Memo(title: "더미11", content: "컨텐츠안녕하세요1")]
    private var awayData: [Memo] = []
    private var index = 0
    private let addButton = UIButton()
    private let collectionViewButton = UIButton()
    private var diffableeDatasource: UITableViewDiffableDataSource<Section, Memo>!
    private let tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setTableView()
        applySnapshot()
    }
    
    private func setUI() {
        self.view.backgroundColor = .white.withAlphaComponent(0.8)
        
        tableView.sectionHeaderTopPadding = 11
        
        collectionViewButton.setTitle("CollectionView로 가보기", for: .normal)
        collectionViewButton.setTitleColor(.systemBlue, for: .normal)
        collectionViewButton.addTarget(self, action: #selector(tappedCollectionViewButton), for: .touchUpInside)
        
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.systemBlue, for: .normal)
        addButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }

    private func setLayout() {
        [tableView, addButton, collectionViewButton].forEach { view.addSubview($0) }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        collectionViewButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(addButton.snp.top)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    private func createNewMemo() -> Memo {
        return Memo(title: "\(index) 메모", content: "새로운 콘텐츠 \(index)")
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.register(MemoTVC.self, forCellReuseIdentifier: MemoTVC.identifier)
        tableView.register(HeaderTVC.self, forHeaderFooterViewReuseIdentifier: HeaderTVC.identifier)
        tableView.register(FooterTVC.self, forHeaderFooterViewReuseIdentifier: FooterTVC.identifier)
        
        diffableeDatasource = UITableViewDiffableDataSource<Section, Memo> (tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTVC.identifier, for: indexPath) as? MemoTVC else { return UITableViewCell() }
            switch indexPath.section {
            case 0:
                cell.setData(title: self.homeData[indexPath.row].title, sub: self.homeData[indexPath.row].content)
            case 1:
                cell.setData(title: self.awayData[indexPath.row].title, sub: self.awayData[indexPath.row].content)
                cell.backgroundColor = .yellow.withAlphaComponent(0.5)
            default:
                break
            }
            return cell
        })
        
        
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Memo>()
        snapshot.appendSections([.home, .away])
        snapshot.appendItems(homeData, toSection: .home)
        snapshot.appendItems(awayData, toSection: .away)
        diffableeDatasource.apply(snapshot)
    }
    
    @objc
    private func tappedButton() {
        index += 1
        if index % 2 == 0 {
            homeData.append(createNewMemo())
        } else {
            awayData.append(createNewMemo())
        }
        
        applySnapshot()
    }
    
    @objc
    private func tappedCollectionViewButton() {
        let collectionVC = ViewController()
        self.present(collectionVC, animated: true)
    }
}

extension TableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTVC.identifier) as? HeaderTVC else { return UITableViewHeaderFooterView() }
        switch section {
        case 0:
            header.setTitle(title: "home")
        default:
            header.setTitle(title: "away")
        }
        header.backgroundColor = .gray
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterTVC.identifier) as? FooterTVC else { return UITableViewHeaderFooterView() }
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if homeData.count >= 2 {
                return .zero
            }
        case 1:
            if awayData.count >= 2 {
                return .zero
            }
        default:
            break
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
