//
//  ViewModelType.swift
//  ImageInfo
//
//  Created by 양수빈 on 2023/07/06.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output
}
