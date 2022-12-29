//
//  PHPhotoLibrary+Combine.swift
//  PHPhotos
//
//  Created by 양수빈 on 2022/12/04.
//

import Foundation

import Combine
import Photos

extension PHPhotoLibrary {
    static var a/
//        return AnyPublisher.compactMap { publisher in
//            DispatchQueue.main.async {
//                if authorizationStatus() == .authorized {
////                    publisher.sink(true)
//
//                    publisher.receive()
//                } else {
//                    requestAuthorization { newStatus in
//
//                    }
//                }
//            }
//        }
    }
//    static var authorized: Observable<Bool> {
//      return Observable.create { observer in
//        // 이미 접근 허가했다면(true) -> completed
//        // 접근 허가하지 않았다면(false) -> requestAccess -> result -> completed
//        DispatchQueue.main.async {
//          if authorizationStatus() == .authorized {
//            observer.onNext(true)
//            observer.onCompleted()
//          } else {
//            observer.onNext(false)
//            // 접근 권한을 허용한 경우 true 방출
//            // 어떤 쓰레드에서 클로저가 실행을 완료할지 보장하지 않음 -> background 쓰레드로 감
//            requestAuthorization { newStatus in
//              // 같은 쓰레드에서 observable에 대한 모든 구독 코드에 onNext 호출 -> 이를 호출한 다음 작업에서도 background쓰레드에서 돌아감
//              observer.onNext(newStatus == .authorized)
//              observer.onCompleted()
//            }
//          }
//        }
//        return Disposables.create()
//      }
//    }
}
