//
//  PhoneTVC.swift
//  CoreDataTest
//
//  Created by 양수빈 on 2022/11/07.
//

import UIKit

class PhoneTVC: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        memoLabel.text = nil
        phoneLabel.text = nil
    }
    
    func initCell(name: String, memo: String, phone: String) {
        nameLabel.text = name
        memoLabel.text = memo
        phoneLabel.text = phone
    }
}
