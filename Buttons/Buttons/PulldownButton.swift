//
//  PulldownButton.swift
//  Buttons
//
//  Created by 양수빈 on 2022/11/26.
//

import UIKit

class PulldownButton: UIButton {
    var offset = CGPoint.zero
    override func menuAttachmentPoint(for configuration: UIContextMenuConfiguration) -> CGPoint {
        let original = super.menuAttachmentPoint(for: configuration)
        return CGPoint(x: original.x + offset.x, y: original.y + offset.y)
    }
}
