//
//  ViewController.swift
//  Skeleton
//
//  Created by 양수빈 on 2022/03/12.
//

import UIKit

import SnapKit
import SkeletonView

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    
    private var data: [Int] = []
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setCollectionView()
        setSkeletonView()
    }

    // MARK: - Methods
    
    private func setUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCVC.self, forCellWithReuseIdentifier: CustomCVC.identifier)
        collectionViewFlowLayout.scrollDirection = .vertical
    }
    
    private func setSkeletonView() {
        // 컬렉션뷰에 스켈레톤을 사용하겠다
        collectionView.isSkeletonable = true
        // 컬렉션뷰 보이겠다
//        collectionView.showSkeleton(usingColor: .blue.withAlphaComponent(0.5))
        
        // 스켈레톤 애니메이션
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        // 스켈레톤 애니메이션 적용해서 보이기
        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray), animation: animation, transition: .crossDissolve(0.5))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            for i in 0..<10 {
                self.data.append(i)
            }
            self.collectionView.stopSkeletonAnimation()
            self.collectionView.hideSkeleton(reloadDataAfter: true)
        }
    }
}

// MARK: - UICollectionViewDelegate

//extension ViewController: UICollectionViewDelegate {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//}

extension ViewController: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 140)
    }
}

// MARK: - UICollectionViewDataSource

//extension ViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCVC.identifier, for: indexPath) as? CustomCVC else { return UICollectionViewCell() }
//
//        cell.initCell(name: "꼬부기 \(indexPath.item)", number: "자라나라 꼬북아 \(indexPath.item)")
//
//        return cell
//    }
//}

// MARK: - SkeletonCollectionViewDelegate

extension ViewController: SkeletonCollectionViewDelegate {

    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - SkeletonCollectionViewDataSource

extension ViewController: SkeletonCollectionViewDataSource {
    // 스켈레톤 뷰를 만들 cell의 id
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CustomCVC.identifier
    }

    // 스켈레톤 몇개?
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCVC.identifier, for: indexPath) as? CustomCVC else { return UICollectionViewCell() }

        if !data.isEmpty {
            cell.initCell(name: "꼬부기 \(indexPath.item)", number: "자라나라 꼬북아 \(indexPath.item)", image: "꼬부기 1")
        }

        return cell
    }
}
