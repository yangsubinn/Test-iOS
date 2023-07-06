//
//  PhotoService.swift
//  ImageInfo
//
//  Created by 양수빈 on 2023/07/06.
//

import Photos
import UIKit

enum MediaType {
    case all, image, video
    
    var titleText: String {
        switch self {
        case .all:
            return "이미지와 동영상"
        case .image:
            return "이미지"
        case .video:
            return "동영상"
        }
    }
    
    var predicate: NSPredicate {
        let format = "mediaType == %d"
        switch self {
        case .all:
            return .init(
                format: format + " || " + format,
                PHAssetMediaType.image.rawValue,
                PHAssetMediaType.video.rawValue
            )
        case .image:
            return .init(
                format: format,
                PHAssetMediaType.image.rawValue
            )
        case .video:
            return .init(
                format: format,
                PHAssetMediaType.video.rawValue
            )
        }
    }
}

final class PhotoService: NSObject {
    static let shared = PhotoService()
    weak var delegate: PHPhotoLibraryChangeObserver?
    
    override private init() {
        super.init()
//        PHPhotoLibrary.shared().register(self)
    }
    
    
}
