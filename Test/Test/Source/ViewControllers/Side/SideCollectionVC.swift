//
//  SideCollectionVC.swift
//  Test
//
//  Created by 양수빈 on 2022/01/03.
//

import UIKit

import SnapKit

class SideCollectionVC: UIViewController {
    
    enum Section: CaseIterable {
        case first
        case second
    }
    
    // MARK: - Properties
    
    private let appendButton = UIButton()
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    private let newColors: [UIColor] = [.black, .green]
    
    private var tryCount: Int = 0
    private var colors: [UIColor] = [.darkGray, .magenta, .orange, .purple, .brown]
    private var diffableDatasource: UICollectionViewDiffableDataSource<Section, UIColor>!
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    
    /// collectionViewFlowLayout 변수 정의할 때 세팅
//    let collectionViewFlowLayout: UICollectionViewLayout = {
//        let layout = UICollectionViewFlowLayout()
//        let cellWidth = UIScreen.main.bounds.width * (319/375)
//        var cellHeight : CGFloat = 400
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//        let spacing = (UIScreen.main.bounds.width - cellWidth) / 2
//        layout.minimumLineSpacing = 16
//        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
//        layout.scrollDirection = .horizontal
//        return layout
//    }()

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupLayout()
        setupCollectionView()
        setupCollectionViewLayout()
        setAddTarget()
    }
    
    // MARK: - Custom Method
    
    /// collectionView 세팅
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false
        collectionView.register(SideCVC.self, forCellWithReuseIdentifier: SideCVC.identifier)
        
        self.diffableDatasource = UICollectionViewDiffableDataSource<Section, UIColor> (collectionView: self.collectionView) {(UICollectionView, IndexPath, String) -> UICollectionViewCell? in
            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: SideCVC.identifier, for: IndexPath) as? SideCVC else { return UICollectionViewCell() }
            
            cell.backgroundColor = self.colors[IndexPath.item]
            cell.layer.cornerRadius = 26
            
            return cell
        }
        collectionView.delegate = self
        collectionView.dataSource = diffableDatasource
    }
    
    /// collectionViewFlowLayout 세팅
    private func setupCollectionViewLayout() {
        let cellWidth: CGFloat = UIScreen.main.bounds.width * (319/375)
        let cellHeight: CGFloat = 400
        let spacing = (UIScreen.main.bounds.width - cellWidth) / 2

        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(appendButton)
        
        appendButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        collectionView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(appendButton.snp.bottom)
            make.bottom.equalToSuperview()
//            make.height.equalTo(400)
        }
    }
    
    private func setUI() {
        appendButton.setTitle("cell 추가 버튼", for: .normal)
        appendButton.setTitleColor(UIColor.blue, for: .normal)
        appendButton.setTitle("버튼 눌림", for: .highlighted)
        appendButton.setTitleColor(UIColor.red, for: .highlighted)
        appendButton.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    private func setAddTarget() {
        appendButton.addTarget(self, action: #selector(touchAppendButton), for: .touchUpInside)
    }
    
    // DiffableDataSourceSnapshot
    private func setData(arr: [UIColor]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UIColor>()
        snapshot.appendSections([.first, .second])
        snapshot.appendItems(arr)
        self.diffableDatasource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - @objc
    @objc
    func touchAppendButton() {
//        collectionView.reloadData()
        if tryCount == 1 {
            colors.append(contentsOf: newColors)
        }
        setData(arr: colors)
        tryCount += 1
    }
}

// MARK: - UICollectionViewDataSource

//extension SideCollectionVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return colors.count
//    }
//}

    // MARK: - UICollectionViewDelegate

extension SideCollectionVC: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SideCVC.identifier, for: indexPath) as? SideCVC else { return UICollectionViewCell() }
//
//        cell.backgroundColor = colors[indexPath.item]
//        cell.layer.cornerRadius = 26
//
//        return cell
//    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        let cellHeightIncludingSpacing = layout.itemSize.height + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let index = (offset.y + scrollView.contentInset.top) / cellHeightIncludingSpacing
        var roundedIndex = round(index)
        
//        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
//            roundedIndex = floor(index)
//        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
//            roundedIndex = ceil(index)
//        } else {
//            roundedIndex = round(index)
//        }
        
        if scrollView.contentOffset.y > targetContentOffset.pointee.y {
            roundedIndex = floor(index)
        } else if scrollView.contentOffset.y < targetContentOffset.pointee.y {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }
        
//        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
//                         y: -scrollView.contentInset.top)
        offset = CGPoint(x: -scrollView.contentInset.left, y: roundedIndex * cellHeightIncludingSpacing - scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}
