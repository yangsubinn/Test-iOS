//
//  QRCodeView.swift
//  QRTest
//
//  Created by 양수빈 on 2023/01/10.
//

import UIKit

class QRCodeView: UIView {
    
    // MARK: - Properties
    
    private var filter = CIFilter(name: "CIQRCodeGenerator")
    
    // MARK: - UI Components
    
    private var imageView = UIImageView()
    
    // MARK: - Initilaize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func getnerateCode(_ string: String, foregroundColor: UIColor = .black, backgroundColor: UIColor = .white) {
        
        guard let filter = filter, let data = string.data(using: .isoLatin1, allowLossyConversion: false) else { return }
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("M", forKey: "inputCorrectionLevel")
        
        guard let ciImage = filter.outputImage else { return }
        
//        imageView.image = UIImage(ciImage: ciImage, scale: 2.0, orientation: .up)
        
        // 이미지를 선명하게 하는 속성
        let transformed = ciImage.transformed(by: CGAffineTransform.init(scaleX: 10, y: 10))
        
        // QR code 색 커스텀 설정
        // 1. 색상 반전시키기 위한 필터
        let invertFilter = CIFilter(name: "CIColorInvert")
        invertFilter?.setValue(transformed, forKey: kCIInputImageKey)
        
        // 2. grayscale로 변환된 이미지를 alpha로 마스킹된 흰색이미지로 변환
        let alphaFilter = CIFilter(name: "CIMaskToAlpha")
        alphaFilter?.setValue(invertFilter?.outputImage, forKey: kCIInputImageKey)
        
        // imageView 속성 설정
        if let outputImage = alphaFilter?.outputImage {
            imageView.tintColor = foregroundColor
            imageView.backgroundColor = backgroundColor
            
            imageView.image = UIImage(ciImage: outputImage, scale: 2.0, orientation: .up).withRenderingMode(.alwaysTemplate)
            print("imageview")
        } else { return }
    }
}
