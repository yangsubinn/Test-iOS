//
//  MainCoordinator.swift
//  CoordinatorPattern
//
//  Created by 양수빈 on 2022/09/23.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // 첫 화면 시작
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.delegate = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    // Parent - Child Coordinator 관계를 통해 화면 전화
    func buySubscription() {
        // BuyCoordinator 타입의 인스턴스 생성
        let child = BuyCoordinator(navigationController: navigationController)
        // BuyCoordinator의 parent coordinator는 self(MainCoordinator)
        child.parentCoordinator = self
        // BuyCoordinator을 자신(MainCoordinator)의 child coordinator로 추가
        childCoordinators.append(child)
        // BuyViewController(childVC) 화면 전환
        child.start()
    }
    
    // 여기서 화면 전환
    func createAccount() {
        let vc = CreateViewController.instantiate()
        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
        navigationController.present(vc, animated: true)
    }
    
    // Child Coordinator이 일을 마쳤을 때, 지워주는 방법
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            // 클래스의 두 인스턴스(coordinator, child)가 같은 메모리를 가리키고 있으면 (= 같은 인스턴스면) 지우기
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

extension MainCoordinator: UINavigationControllerDelegate {
    // MainCoordinator가 Nacigation Controller의 상호작용을 바로 감지 가능
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        // 이동할 VC
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        // 이동할 VC가 navigationController의 VC들에 포함되어 있으면 return
        // -> 포함되어 있지 않아야 현재 이동할 VC가 사라질 화면이라는 의미 (뒤로 이동)
        if navigationController.viewControllers.contains(fromViewController) { return }
        
        // child coordinator가 일을 끝냈어요
        if let buyViewController = fromViewController as? BuyViewController {
            childDidFinish(buyViewController.coordinator)
        }
    }
}
