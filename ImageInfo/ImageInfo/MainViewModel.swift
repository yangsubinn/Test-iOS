//
//  MainViewModel.swift
//  ImageInfo
//
//  Created by 양수빈 on 2023/07/06.
//

import RxSwift
import RxCocoa

final class MainViewModel: ViewModelType {
    
    // MARK: - Properties
    
    // MARK: - Inputs
    
    struct Input {
//        let albumButtonTapped: Observable<Void>
    }
    
    // MARK: - Outputs
    
    struct Output {
        
    }
    
    // MARK: - Initialize
    
    
}

extension MainViewModel {
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
