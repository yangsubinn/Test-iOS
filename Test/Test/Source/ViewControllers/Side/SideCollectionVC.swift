//
//  SideCollectionVC.swift
//  Test
//
//  Created by 양수빈 on 2022/01/03.
//

import UIKit

import SnapKit

class SideCollectionVC: UIViewController {
    
    // MARK: - Properties
    
    var colors: [UIColor] = [.darkGray, .magenta, .orange, .purple, .brown]
    
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
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    
    let collectionViewFlowLayout = UICollectionViewFlowLayout()

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    // MARK: - Custom Method
    
    /// collectionView 세팅
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SideCVC.self, forCellWithReuseIdentifier: SideCVC.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false
    }
    
    /// collectionViewFlowLayout 세팅
    private func setupCollectionViewLayout() {
        let cellWidth: CGFloat = UIScreen.main.bounds.width * (319/375)
        let cellHeight: CGFloat = 400
        let spacing = (UIScreen.main.bounds.width - cellWidth) / 2

        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension SideCollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

    // MARK: - UICollectionViewDelegate

extension SideCollectionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SideCVC.identifier, for: indexPath) as? SideCVC else { return UICollectionViewCell() }
        
        cell.backgroundColor = colors[indexPath.item]
        cell.layer.cornerRadius = 26
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
                         y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}