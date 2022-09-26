//
//  TestViewModel.swift
//  MVVM-RxSwift
//
//  Created by 양수빈 on 2022/09/24.
//

//import RxSwift
//import RxRelay
import Combine

class TestViewModel: ViewModelType {
    
    // Rx
//    private let disposeBag = DisposeBag()
    
    // Combine
    private var cancelBag = Set<AnyCancellable>()
    
    struct Input {
        // Rx
//        let email: Observable<String?>
//        let password: Observable<String?>
//        let tapLogIn: Observable<UserData>
        
        // Combine
        let email: AnyPublisher<String?, Error>
        let password: AnyPublisher<String?, Error>
        let tapLogin: AnyPublisher<UserData, Error>
    }
    
    struct Output {
        // Rx
//        let enableLogInButton = BehaviorRelay<Bool>(value: false)
//        let errorMessage = PublishRelay<String>()
//        let logInSuccess = PublishRelay<Void>()
        
        // Combine
        let enableLogInButton = CurrentValueSubject<Bool, Error>.init(false)
        let errorMessage = PassthroughSubject<String, Error>()
        let logInSuccess = PassthroughSubject<Void, Error>()
    }
    
    init() { }
}

extension TestViewModel {
    /// CleanArchitecture: - input에 따라 useCase로 연결
    // Rx
//    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
//        let output = Output()
////        self.bindOutput(output: output, disposeBag: disposeBag)
//
//        Observable.combineLatest(input.email, input.password)
//            .filter { $0.0 != nil && $0.1 != nil }
//            .subscribe(onNext: { str in
//                if str.0!.count > 0 && str.1!.count > 0 {
//                    output.enableLogInButton.accept(true)
//                } else {
//                    output.enableLogInButton.accept(false)
//                }
//            })
//            .disposed(by: disposeBag)
//
//        input.tapLogIn.subscribe(onNext: { data in
//            if data.email == "subin" && data.password == "0000" {
//                print("로그인 경축")
//            } else {
//                print("로그인 실패")
//            }
//        })
//        .disposed(by: disposeBag)
//
//        return output
//    }
    
    // Combine
    func transform(from input: Input) -> Output {
        let output = Output()
        
        input.email.combineLatest(input.password)
            .filter { $0.0 != nil && $0.1 != nil }
            .sink(receiveCompletion: { event in
                print("completion \(event)")
            }, receiveValue: { str in
                if str.0!.count > 0 && str.1!.count > 0 {
                    output.enableLogInButton.send(true)
                } else {
                    output.enableLogInButton.send(false)
                }
            })
            .store(in: &cancelBag)
        
        input.tapLogin
            .sink(receiveCompletion: { event in
                print("completion \(event)")
            }, receiveValue: { value in
                if value.email == "subin" && value.password == "0000" {
                    print("로그인 경축")
                } else {
                    print("로그인 실패")
                }
            })
            .store(in: &cancelBag)
        
        return output
    }
    
    /// CleanArchitecture: - useCase로부터 받아온 로직 처리 결과 데이터를 output에 accept로 넣어줌
//    private func bindOutput(output: Output, disposeBag: DisposeBag) {
//
//    }
}
