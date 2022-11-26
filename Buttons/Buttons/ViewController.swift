//
//  ViewController.swift
//  Buttons
//
//  Created by 양수빈 on 2022/11/26.
//

import UIKit

class ViewController: UIViewController {
    
    let pulldownButton = PulldownButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setUI()
//        self.pulldownButton.addAction(UIAction {_ in self.setPulldownButton()}, for: .touchUpInside)
        self.pulldownButton.addTarget(self, action: #selector(setPulldownButton), for: .touchUpInside)
    }
    
    func setLayout() {
        self.view.addSubview(pulldownButton)
        
        pulldownButton.translatesAutoresizingMaskIntoConstraints = false
        pulldownButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pulldownButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setUI() {
        self.pulldownButton.setTitle("전체 미션", for: .normal)
        self.pulldownButton.setTitleColor(.purple, for: .normal)
        self.pulldownButton.setTitleColor(.red, for: .highlighted)
    }
    
    @objc
    func setPulldownButton() {
        let all = UIAction(title: "전체", handler: { _ in print("전체") })
        let completed = UIAction(title: "완료", handler: { _ in print("완료") })
        let inCompleted = UIAction(title: "미완료", handler: { _ in print("미완료") })
        
        self.pulldownButton.menu = UIMenu(options: .displayInline,
                                          children: [all, completed, inCompleted])
        
        // button과 menu 사이 offset 지정 -> PulldownButton.menuAttachmentPoint
        self.pulldownButton.offset = CGPoint(x: 0, y: 50)
        
        // press가 아닌 touchUp 했을때 바로 메뉴가 나타나도록 (default = false)
        self.pulldownButton.showsMenuAsPrimaryAction = true
        self.pulldownButton.changesSelectionAsPrimaryAction = false
    }
}

