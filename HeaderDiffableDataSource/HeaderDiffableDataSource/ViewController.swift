//
//  ViewController.swift
//  HeaderDiffableDataSource
//
//  Created by 양수빈 on 2023/02/01.
//

import UIKit
import SnapKit

enum Section: CaseIterable {
    case home
    case away
}

class ViewController: UIViewController {
    
    private var homeData: [Memo] = [Memo(title: "더미11", content: "컨텐츠안녕하세요1")]
    private var awayData: [Memo] = []
    private var index = 0
    private let addButton = UIButton()
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    private var diffableDatasource: UICollectionViewDiffableDataSource<Section, Memo>!
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setUI()
        setCollectionView()
        applySnapshot()
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        
        collectionView.backgroundColor = .clear
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }

    private func setLayout() {
        [collectionView, addButton].forEach { view.addSubview($0) }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setCollectionView() {
//        collectionView.register(MemoCVC.self, forCellWithReuseIdentifier: MemoCVC.identifier)
        
//        diffableDatasource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: MemoCVC.identifier, for: indexPath) as? MemoCVC else { return UICollectionViewCell() }
//            switch indexPath.section {
//            case 0:
//
//                cell.setData(title: self.homeData[indexPath.row].title, sub: self.homeData[indexPath.row].content)
//            case 1:
//                cell.setData(title: self.awayData[indexPath.row].title, sub: self.awayData[indexPath.row].content)
//                cell.backgroundColor = .yellow.withAlphaComponent(0.5)
//            default:
//                break
//            }
//            return cell
//        })
        
        let headerRegister = UICollectionView.SupplementaryRegistration<HeaderCell> (elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            if indexPath.section == 0 {
                supplementaryView.setTitle(title: "home")
            } else {
                supplementaryView.setTitle(title: "away")
            }
        }
        
        let footerRegister = UICollectionView.SupplementaryRegistration<FooterCell> (elementKind: UICollectionView.elementKindSectionFooter) { supplementaryView, elementKind, indexPath in
            supplementaryView.showFooter()
            switch indexPath.section {
            case 0:
                supplementaryView.titleLabel.textColor = .green
                if self.homeData.count >= 2 { supplementaryView.hiddenFooter() }
            case 1:
                supplementaryView.titleLabel.textColor = .red
                if self.awayData.count >= 2 { supplementaryView.hiddenFooter() }
            default:
                break
            }
        }
        
        let cellRegister = UICollectionView.CellRegistration<MemoCVC, Memo> { cell, indexPath, itemIdentifier in
            switch indexPath.section {
            case 0:
                cell.setData(title: self.homeData[indexPath.row].title, sub: self.homeData[indexPath.row].content)
            case 1:
                cell.setData(title: self.awayData[indexPath.row].title, sub: self.awayData[indexPath.row].content)
                cell.backgroundColor = .yellow.withAlphaComponent(0.5)
            default:
                break
            }
        }
        
        diffableDatasource = UICollectionViewDiffableDataSource<Section, Memo>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegister, for: indexPath, item: itemIdentifier)
        })
        
        diffableDatasource.supplementaryViewProvider = { (view, string, index) in
            if string == UICollectionView.elementKindSectionFooter {
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: footerRegister, for: index)
            } else {
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegister, for: index)
            }
        }
        
        collectionView.delegate = self
        collectionView.dataSource = diffableDatasource
        collectionViewFlowLayout.scrollDirection = .vertical
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Memo>()
        snapshot.appendSections([.home, .away])
        snapshot.appendItems(homeData, toSection: .home)
        snapshot.appendItems(awayData, toSection: .away)
        diffableDatasource.apply(snapshot)
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
    
    private func createNewMemo() -> Memo {
        return Memo(title: "\(index) 메모", content: "새로운 콘텐츠 \(index)")
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        return CGSize(width: width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        var height: CGFloat = 40
        print("1️⃣ homeData:", self.homeData.count, "awayData:", self.awayData.count)
        
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
        return CGSize(width: width, height: height)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        return CGSize(width: width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
