//
//  ViewController.swift
//  ImageInfo
//
//  Created by 양수빈 on 2023/07/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import PhotosUI
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let albumButton = UIButton()
    private let imagePicker = UIImagePickerController()
    private let imageView = UIImageView()
    private let dateLabel = UILabel()
    private let locationLabel = UILabel()

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        bindButton()
    }
    
    // MARK: - Methods
    
    private func bindButton() {
        albumButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.requestAlbum()
            }.disposed(by: disposeBag)
    }
    
    private func requestAlbum() {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .videos])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        dateLabel.textColor = .darkGray
        dateLabel.text = "date"
        locationLabel.textColor = .gray
        locationLabel.text = "location"
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 20)
        container.foregroundColor = .systemBlue
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("앨범에서 가져오기", attributes: container)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        albumButton.configuration = configuration
    }
    
    private func setLayout() {
        [imageView, albumButton, dateLabel, locationLabel].forEach({
            self.view.addSubview($0)
        })
        
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.imageView.snp.width).multipliedBy(1)
            make.center.equalToSuperview()
        }
        
        albumButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(imageView.snp.top).offset(-20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.leading.equalTo(dateLabel.snp.trailing).offset(16)
        }
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let assetID = results.first?.assetIdentifier {
            let assetResult = PHAsset.fetchAssets(withLocalIdentifiers: [assetID], options: nil)
            
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy.MM.dd"
            let date = dateformatter.string(from: assetResult.firstObject?.creationDate ?? Date())
            dateLabel.text = "\(date)"
            
            // 위도, 경도 -> 지역 변환(CLPlacemark)
            let coord = assetResult.firstObject?.location?.coordinate
            if let lat = coord?.latitude, let lon = coord?.longitude {
                let address = CLGeocoder.init()
                address.reverseGeocodeLocation(CLLocation(latitude: lat, longitude: lon)) { place, error in
                    if let place = place?.first,
                       let country = place.country, let administer = place.administrativeArea, let name = place.name {
                        print("9️⃣", place)
                        self.locationLabel.text = "\(country) \(administer), \(name)"
                    }
                }
            } else {
                locationLabel.text = "No Location"
            }
        }
        
        if let itemProvider = results.first?.itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.imageView.image = image as? UIImage
                }
            }
        }
    }
}

