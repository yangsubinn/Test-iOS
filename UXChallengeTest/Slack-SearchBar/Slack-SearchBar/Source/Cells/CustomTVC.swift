//
//  CustomTVC.swift
//  Slack-SearchBar
//
//  Created by 양수빈 on 2021/10/10.
//

import UIKit

class CustomTVC: UITableViewCell {
    static let identifier = "CustomTVC"
    
    let iconImageView = UIImageView()
    let titleLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("CustomTVC 불려옴")
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        iconImageView.tintColor = .purple

        titleLabel.text = "바밤바"
    }
    
    func setupLayout() {
        addSubview(iconImageView)
        addSubview(titleLabel)

        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.centerY.equalTo(iconImageView.snp.centerY)
        }
    }
    
}
