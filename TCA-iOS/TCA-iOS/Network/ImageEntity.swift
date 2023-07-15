//
//  ImageEntity.swift
//  TCA-iOS
//
//  Created by 양수빈 on 2023/07/15.
//

import Foundation

struct ImageEntity: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [ImageItemEntity]
}

// MARK: - Item
struct ImageItemEntity: Codable {
    let title: String
    let link: String
    let thumbnail: String
    let sizeheight, sizewidth: String
    
//    func toModel(id: Int) -> ImageItem {
//        return ImageItem(id: id, imageUrl: thumbnail, title: title, isPinned: false)
//    }
}
