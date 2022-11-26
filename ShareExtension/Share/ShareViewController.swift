//
//  ShareViewController.swift
//  Share
//
//  Created by 양수빈 on 2022/11/25.
//

import UIKit
import Social
import MobileCoreServices

// MARK: - Custom ShareViewController

class ShareViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        let extensionItems = extensionContext?.inputItems as! [NSExtensionItem]
        
        for extensionItem in extensionItems {
            if let itemProviders = extensionItem.attachments {
                for itemProvider in itemProviders {
                    // 해당 객체가 있는지 식별
                    if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
                        itemProvider.loadItem(forTypeIdentifier: kUTTypeImage as String, options: nil, completionHandler: { result, error in
                            var image: UIImage?
                            if result is UIImage {
                                image = result as? UIImage
                            }
                            
                            if result is URL {
                                let data = try? Data(contentsOf: result as! URL)
                                image = UIImage(data: data!)!
                            }
                            
                            if result is Data {
                                image = UIImage(data: result as! Data)!
                            }
                            
                            DispatchQueue.main.async {
                                if let image = image {
                                    self.imageView.image = image
                                }
                            }
                        })
                    }
                    
                    if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                        itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil, completionHandler: { result, error in
                            let data = NSData.init(contentsOf:result as! URL)
                            DispatchQueue.main.async {
                                if let urlStr = result {
                                    self.textView.text = "\(urlStr)"
                                }
                            }
                        })
                    }
                }
            }
        }
    }
    
    func hideExtensionWithCompletionHandler(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationController?.view.transform = CGAffineTransform(translationX: 0, y:self.navigationController!.view.frame.size.height)
        }, completion: completion)
    }
    
    @IBAction func touchupOkButton(_ sender: Any) {
        // 처리후 종료
        // suiteName: AppGroup identifier 
        if let userDefaults = UserDefaults(suiteName: "group.subin.Share") {
            if let image = imageView.image {
                userDefaults.set(image.pngData(), forKey: "image")
            }
            
            if let text = textView.text {
                userDefaults.set(text, forKey: "text")
            }
        }
        
        self.hideExtensionWithCompletionHandler(completion: { _ in
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
        })
    }
    
    @IBAction func touchupDismissButton(_ sender: Any) {
        self.hideExtensionWithCompletionHandler(completion: { _ in
            self.extensionContext?.completeRequest(returningItems: nil)
        })
    }
    
}

// MARK: - 기본 ShareViewController

//class ShareViewController: SLComposeServiceViewController {
//
//    /// compose view에 텍스트가 입력될때마다 호출되는 함수
//    /// - 우측 상단의 Post 버튼 활성화 여부 결정
//    /// - true (활성화), false (비활성화)
//    override func isContentValid() -> Bool {
//        // Do validation of contentText and/or NSExtensionContext attachments here
//        // 항상 활성화
////        return true
//
//        // 텍스트가 있어야 활성화
//        return self.contentText.isEmpty == false
//    }
//
//    /// Post 버튼 눌렀을때 호출되는 함수
//    override func didSelectPost() {
//        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
//
//        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
//    }
//
//    /// Cancel 버튼 눌렀을때 호출되는 함수
////    override func didSelectCancel() {
////
////    }
//
//    /// compose view에 configuration item 표시해야 하는 경우
//    override func configurationItems() -> [Any]! {
//        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
//        let item = SLComposeSheetConfigurationItem()!
//        item.title = "Title"
//        item.value = "ShareExtension"
//        item.tapHandler = {
//            print("tap")
//            let vc = ShareViewController()
//            self.pushConfigurationViewController(vc)
//        }
//        return [item]
//    }
//}
