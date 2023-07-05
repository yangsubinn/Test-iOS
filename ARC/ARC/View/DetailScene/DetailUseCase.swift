//
//  DetailUseCase.swift
//  ARC
//
//  Created by 양수빈 on 2023/02/15.
//

import Foundation

protocol DetailUseCase {
    
}

final class DefaultDetailUseCase {
    
    init() {
        print("DefaultDetailUseCase - init")
    }
    
    deinit {
        print("DefaultDetailUseCase - deinit")
    }
}

extension DefaultDetailUseCase: DetailUseCase {
    
}
