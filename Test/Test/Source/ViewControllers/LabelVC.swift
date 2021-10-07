//
//  LabelVC.swift
//  Test
//
//  Created by 양수빈 on 2021/10/07.
//

import UIKit
import SnapKit

class LabelVC: UIViewController {
    
    // MARK: - Properties
    let testLabel = UILabel()
    let testTwoLabel = UILabel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
    }
    
    // MARK: - Custom Method
    func configUI() {
        testLabel.text = "다양한 캐츄와 함께, 모두의 매일을 다채롭게"
        testLabel.bold(targetString: "모두의 매일")
        
//        testTwoLabel.text = "안녕하세요 양수빈입니당"
        testTwoLabel.attributedText = NSMutableAttributedString()
            .regular(string: "안녕하세요", fontSize: 20)
            .orangeHighlight("양수빈")
            .blackHighlight("입니당")
    }
    
    func setupLayout() {
        view.addSubview(testLabel)
        view.addSubview(testTwoLabel)
        
        testLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(300)
        }
        
        testTwoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(testLabel.snp.bottom).offset(30)
        }
    }

}

// MARK: - UILabel
extension UILabel {
    func bold(targetString: String) {
        let fontSize = self.font.pointSize
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
}

// MARK: - NSMutableAttributedString
extension NSMutableAttributedString {

    var fontSize: CGFloat {
        return 14
    }
    var boldFont: UIFont {
        return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
    var normalFont: UIFont {
        return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }

    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func regular(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func orangeHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.orange
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func blackHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.black

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func underlined(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
