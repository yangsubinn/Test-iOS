//
//  ActivityView.swift
//  ActivityView-SwiftUI
//
//  Created by 양수빈 on 2023/07/19.
//

import SwiftUI
import LinkPresentation
import CoreServices

struct ActivityItem {
    var items: [Any]
    var activities: [UIActivity] = []
    var excludedTypes: [UIActivity.ActivityType]
    
    init(items: [Any], activities: [UIActivity], excludedTypes: [UIActivity.ActivityType]) {
        self.items = items
        self.activities = activities
        self.excludedTypes = excludedTypes
    }
}

struct ActivityView: UIViewControllerRepresentable {
//    @Binding var item: ActivityItem?
//    var permittedArrowDirections: UIPopoverArrowDirection
//    var completion: UIActivityViewController.CompletionWithItemsHandler?
//
//    init(item: Binding<ActivityItem?>, permittedArrowDirections: UIPopoverArrowDirection, completion: UIActivityViewController.CompletionWithItemsHandler? = nil) {
//        _item = item
//        self.permittedArrowDirections = permittedArrowDirections
//        self.completion = completion
//    }
//
//    func makeUIViewController(context: Context) -> ActivityViewControllerWrapper {
//        ActivityViewControllerWrapper(
//            item: $item,
//            permittedArrowDirections: permittedArrowDirections,
//            completion: completion
//        )
//    }
//
//    func updateUIViewController(_ controller: ActivityViewControllerWrapper, context: Context) {
//        controller.item = $item
//        controller.completion = completion
//        controller.updateState()
//    }
    
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

final class ActivityViewControllerWrapper: UIViewController {
    var item: Binding<ActivityItem?>
    var permittedArrowDirections: UIPopoverArrowDirection
    var completion: UIActivityViewController.CompletionWithItemsHandler?
    
    init(
        item: Binding<ActivityItem?>,
        permittedArrowDirections: UIPopoverArrowDirection,
        completion: UIActivityViewController.CompletionWithItemsHandler?)
    {
        self.item = item
        self.permittedArrowDirections = permittedArrowDirections
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        updateState()
    }
    
    func updateState() {
        let isActivityPresented = presentedViewController != nil
        
        if item.wrappedValue != nil {
            if !isActivityPresented {
                let controller = UIActivityViewController(
                    activityItems: item.wrappedValue?.items ?? [],
                    applicationActivities: item.wrappedValue?.activities
                )
                
                controller.excludedActivityTypes = item.wrappedValue?.excludedTypes
                controller.popoverPresentationController?.permittedArrowDirections = permittedArrowDirections
                controller.popoverPresentationController?.sourceView = view
                
                controller.completionWithItemsHandler = { [weak self] (activityType, success, items, error) in
                    self?.item.wrappedValue = nil
                    self?.completion?(activityType, success, items, error)
                }
                
                present(controller, animated: true, completion: nil)
            }
        }
    }
    
}
