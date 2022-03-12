//
//  CustomCVC.swift
//  Skeleton
//
//  Created by 양수빈 on 2022/03/12.
//

import UIKit

import SkeletonView

class CustomCVC: UICollectionViewCell {
    
    static let identifier = "CustomCVC"
    
    // MARK: - Properties
    
    private let userImageView = UIImageView()
    private let nameLabel = UILabel()
    private let numberLabel = UILabel()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setSkeleton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = UIImage()
        nameLabel.text = ""
        numberLabel.text = ""
    }
    
    // MARK: - Methods
    
    private func setSkeleton() {
        self.isSkeletonable = true
        userImageView.isSkeletonable = true
        nameLabel.isSkeletonable = true
        numberLabel.isSkeletonable = true
        
        userImageView.skeletonCornerRadius = 4
        nameLabel.linesCornerRadius = 4
        numberLabel.linesCornerRadius = 4
        
        nameLabel.skeletonTextLineHeight = .fixed(20)
        numberLabel.skeletonTextLineHeight = .fixed(20)
        
        nameLabel.skeletonLineSpacing = 10
        numberLabel.skeletonLineSpacing = 10
    }
    
    private func setUI() {
        nameLabel.font = .systemFont(ofSize: 24)
        nameLabel.textColor = .black
        
        numberLabel.font = .systemFont(ofSize: 18)
        numberLabel.textColor = .gray
    }
    
    private func setLayout() {
//        self.addSubview(userImageView)
//        self.addSubview(nameLabel)
//        self.addSubview(numberLabel)
        
        // 각 요소별로 스켈레톤을 적용하려면 contentView에 addSubview 해야한다.
        self.contentView.addSubview(userImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(numberLabel)
        
        userImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(16)
            make.width.equalTo(userImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
    
    func initCell(name: String, number: String, image: String) {
        nameLabel.text = name
        numberLabel.text = number
        userImageView.image = UIImage(named: image)
    }
}
