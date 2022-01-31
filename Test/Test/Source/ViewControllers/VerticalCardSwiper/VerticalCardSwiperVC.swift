//
//  VerticalCardSwiperVC.swift
//  Test
//
//  Created by 양수빈 on 2021/09/29.
//

import UIKit
import VerticalCardSwiper

class VerticalCardSwiperVC: UIViewController, VerticalCardSwiperDatasource, VerticalCardSwiperDelegate {
    
    private var cardSwiper: VerticalCardSwiper!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        
        
        cardSwiper = VerticalCardSwiper(frame: self.view.frame)
                                        /// (UIEdgeInsets(top: 30, left: 20, bottom: 20, right: 20))
                                        /// CGRect(x: 20, y: 20, width: 300, height: 400)
        
//        cardSwiper.snp.makeConstraints { make in
////            make.top.equalToSuperview().offset(50)
////            make.leading.trailing.equalTo().offset(30)
////            make.bottom.equalToSuperview().inset(40)
//        }
        view.addSubview(cardSwiper)
        
        cardSwiper.datasource = self
        cardSwiper.delegate = self
        
        // register cardcell for storyboard use
        cardSwiper.register(ExampleCardCell.self, forCellWithReuseIdentifier: "ExampleCell")
        
    }
    
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "ExampleCell", for: index) as? ExampleCardCell {
            return cardCell
        }
        
        
        return CardCell()
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return 5
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
