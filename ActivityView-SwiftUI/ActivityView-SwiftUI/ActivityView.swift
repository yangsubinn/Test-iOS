//
//  ActivityView.swift
//  ActivityView-SwiftUI
//
//  Created by 양수빈 on 2023/07/19.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    public let activityItems: [Any]
    public let applicationActivities: [UIActivity]?

    func makeUIViewController(context: Context) -> some UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)

        if isPresented && uiViewController.presentedViewController == nil {
            uiViewController.present(activityVC, animated: true)
        }
        activityVC.completionWithItemsHandler = { (_, _, _, _) in
            isPresented = false
        }
    }
}
