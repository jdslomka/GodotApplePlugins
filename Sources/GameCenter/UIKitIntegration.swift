//
//  UIKitIntegration.swift
//  SwiftGodotAppleTemplate
//
//  Created by Miguel de Icaza on 11/14/25.
//
#if canImport(UIKit)
import UIKit

extension UIApplication {
    var activeWindowScene: UIWindowScene? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }
    }

    var keyWindow: UIWindow? {
        // Preferred for iOS 13+
        if let scene = activeWindowScene {
            return scene.windows.first { $0.isKeyWindow }
        }
        // Fallback (older / weird cases)
        return windows.first { $0.isKeyWindow }
    }

    var topMostViewController: UIViewController? {
        guard let root = keyWindow?.rootViewController else { return nil }
        return root.mostVisibleViewController
    }
}

extension UIViewController {
    /// Recursively find the "most visible" child or presented controller
    var mostVisibleViewController: UIViewController {
        if let nav = self as? UINavigationController {
            return nav.visibleViewController?.mostVisibleViewController ?? nav
        }
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.mostVisibleViewController ?? tab
        }
        if let presented = presentedViewController {
            return presented.mostVisibleViewController
        }
        return self
    }
}

@MainActor
func topMostViewController() -> UIViewController? {
    UIApplication.shared.topMostViewController
}

@MainActor
func presentOnTop(_ vc: UIViewController) {
    guard let vc = topMostViewController() else {
        print("Could not find the top view controller")
        return
    }
    vc.present(vc, animated: true)
}
#endif
