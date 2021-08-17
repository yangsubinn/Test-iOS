//
//  AnimationVC.swift
//  Test
//
//  Created by 양수빈 on 2021/08/17.
//

import UIKit

class AnimationVC: UIViewController {
    
    let object = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(object)
        
        object.backgroundColor = .purple
        object.layer.cornerRadius = 70
        
        object.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(140)
        }
        
        animation()
    }
    
    func animation() {
        UIView.animate(withDuration: 1.0, delay: 0.5, animations: {
            let frame = CGAffineTransform(translationX: 0, y: -100) /// y축 방향으로 -100만큼
                        self.object.transform = frame
        },
        // 위에 애니메이션이 끝난 다음에 실행되는 부분
        completion: {finished in
            UIView.animate(withDuration: 1.0,
                           animations: {
                self.object.alpha = 0
            }, completion: { finished in
                UIView.animate(withDuration: 2.0,
                               delay: 0.2,
                               options: [.repeat, .curveEaseInOut]) {
                    self.object.backgroundColor = .orange
                    self.object.alpha = 1.0
                }
            }
        )}
    )}
    // y축 방향으로 -100만큼 이동 -> 알파값 0으로 -> 다시 배경 주황색으로 바꾸면서 알파값 1로 (easyInOut으로 계속 반복)
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
