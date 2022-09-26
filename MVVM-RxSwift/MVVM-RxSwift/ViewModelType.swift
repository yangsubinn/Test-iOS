//
//  ViewModelType.swift
//  MVVM-RxSwift
//
//  Created by 양수빈 on 2022/09/24.
//

import Foundation
//import RxSwift

protocol ViewModelType{
    associatedtype Input
    associatedtype Output
  
    // Rx
//  func transform(from input: Input, disposeBag: DisposeBag) -> Output
    
    // Combine
    func transform(from input: Input) -> Output
}
