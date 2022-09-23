//
//  BuyCoordinator.swift
//  CoordinatorPattern
//
//  Created by 양수빈 on 2022/09/23.
//

import UIKit

class BuyCoordinator: Coordinator {
    
    // retain cycle 피하기 위해 weak 참조 선언
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // 화면 보여주기 시작
    func start() {
        let vc = BuyViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
