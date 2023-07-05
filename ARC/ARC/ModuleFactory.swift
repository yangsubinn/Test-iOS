//
//  ModuleFactory.swift
//  ARC
//
//  Created by 양수빈 on 2023/02/15.
//

import UIKit

protocol ModuleFactoryProtocol {
    func makeDetailVC() -> DetailViewController
    func makeNextVC() -> NextViewController
}

final class ModuleFactory: ModuleFactoryProtocol {
    static let shared = ModuleFactory()
    private init() {}
    
    func makeDetailVC() -> DetailViewController {
        let useCase = DefaultDetailUseCase()
        let viewModel = DetailViewModel(useCase: useCase)
        let detailVC = DetailViewController()
        detailVC.viewModel = viewModel
        return detailVC
    }
    
    func makeNextVC() -> NextViewController {
        let viewModel = NextViewModel()
        let nextVC = NextViewController()
        nextVC.viewModel = viewModel
        return nextVC
    }
}
