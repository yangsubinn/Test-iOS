//
//  CustomCVC.swift
//  Skeleton
//
//  Created by 양수빈 on 2022/03/12.
//

import UIKit

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
    
    private func setUI() {
        userImageView.image = UIImage(named: "꼬부기 1")
        userImageView.layer.cornerRadius = 4
        
        nameLabel.font = .systemFont(ofSize: 24)
        nameLabel.textColor = .black
        
        numberLabel.font = .systemFont(ofSize: 18)
        numberLabel.textColor = .gray
    }
    
    private func setLayout() {
        self.addSubview(userImageView)
        self.addSubview(nameLabel)
        self.addSubview(numberLabel)
        
        userImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(16)
            make.width.equalTo(userImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(16)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
    }
    
    func initCell(name: String, number: String) {
        nameLabel.text = name
        numberLabel.text = number
    }
}
