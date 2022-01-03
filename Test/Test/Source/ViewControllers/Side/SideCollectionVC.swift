//
//  SideCollectionVC.swift
//  Test
//
//  Created by 양수빈 on 2022/01/03.
//

import UIKit

import SnapKit

class SideCollectionVC: UIViewController {
    
    var colors: [UIColor] = [.darkGray, .magenta, .orange, .purple, .brown]
    
    let collectionViewFlowLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        let cellWidth = UIScreen.main.bounds.width * (319/375)
        var cellHeight : CGFloat = 400
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        let spacing = (UIScreen.main.bounds.width - cellWidth) / 2
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
//    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    let cellSize = CGSize(width: UIScreen.main.bounds.width * (319/375), height: 400)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.collectionViewLayout = collectionViewFlowLayout
//        collectionViewFlowLayout.scrollDirection = .horizontal
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SideCVC.self, forCellWithReuseIdentifier: SideCVC.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false
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

extension SideCollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

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

//extension SideCollectionVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return cellSize
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 16
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        let spacing = (UIScreen.main.bounds.width - cellSize.width) / 2
//        return UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
//    }
//}
