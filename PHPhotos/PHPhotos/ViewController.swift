//
//  ViewController.swift
//  PHPhotos
//
//  Created by 양수빈 on 2022/11/30.
//

import UIKit

import Combine
import PhotosUI

class ViewController: UIViewController {
    
    private let photo = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authorized = PHPhotoLibrary.authorized.share()
        
        
        
//        authorized
//          .skip(1) // 진입시 접근허용하지 않은 경우 1회 스킵
//          .takeLast(1) // 마지막 요소(다시 한번 접근허용 물어봤을때 최근 답)
//          .filter { $0 == false }
//          .subscribe(onNext: { [weak self] _ in
//            guard let errorMessage = self?.errorMessage else { return }
//            DispatchQueue.main.async(execute: errorMessage)
//          }).disposed(by: disposeBag)
    }

    @IBAction func tappedButton(_ sender: Any) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .authorized:
                print("사진 권한 허용")
                self.openLibrary()
            default:
                print("사진 권한 없음")
            }
        }
    }
    
    private func openLibrary() {
        if #available(iOS 14, *) {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 1
            configuration.filter = .any(of: [.images, .livePhotos])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            
            self.present(picker, animated: true)
        } else {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true)
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
    }
}

