//
//  DetailViewModel.swift
//  ARC
//
//  Created by 양수빈 on 2023/02/15.
//

import Foundation

final class DetailViewModel {
    
    private let useCase: DetailUseCase
    
    init(useCase: DetailUseCase) {
        self.useCase = useCase
        print("DetailViewModel - init")
    }
    
    deinit {
        print("DetailViewModel - deinit")
    }
}
