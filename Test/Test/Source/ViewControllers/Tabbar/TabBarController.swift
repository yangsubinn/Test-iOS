//
//  TabBarController.swift
//  Test
//
//  Created by 양수빈 on 2021/12/26.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// 특정 뷰의 탭바 컬러를 바꿔주고 싶으면 viewWillAppear에서
        /// 전체 탭바 컬러를 바꿔주고 싶으면 AppDelegate > didFinishLaunchingWithOptions에서
        UITabBar.appearance().tintColor = .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBar()
    }
    
    func setTabBar() {
        guard let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC"),
              let MyVC = self.storyboard?.instantiateViewController(withIdentifier: "MyVC"),
              let OtherVC = self.storyboard?.instantiateViewController(withIdentifier: "OtherVC"),
              let CommunityVC = self.storyboard?.instantiateViewController(withIdentifier: "CommunityVC"),
              let LikeVC = self.storyboard?.instantiateViewController(withIdentifier: "LikeVC")
        else {return}
        
        HomeVC.tabBarItem.title = "Home"
        HomeVC.tabBarItem.image = UIImage(systemName: "house")
        HomeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        MyVC.tabBarItem.title = "My"
        MyVC.tabBarItem.image = UIImage(systemName: "person")
        MyVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        OtherVC.tabBarItem.title = "Other"
        OtherVC.tabBarItem.image = UIImage(systemName: "person.3")
        OtherVC.tabBarItem.selectedImage = UIImage(systemName: "person.3.fill")
        
        CommunityVC.tabBarItem.title = "Community"
        CommunityVC.tabBarItem.image = UIImage(systemName: "keyboard")
        CommunityVC.tabBarItem.selectedImage = UIImage(systemName: "keyboard.fill")
        
        LikeVC.tabBarItem.title = "Like"
        LikeVC.tabBarItem.image = UIImage(systemName: "heart.circle")
        LikeVC.tabBarItem.selectedImage = UIImage(systemName: "heart.circle.fill")
        
        setViewControllers([HomeVC, MyVC, OtherVC, CommunityVC, LikeVC], animated: true)
    }
}
