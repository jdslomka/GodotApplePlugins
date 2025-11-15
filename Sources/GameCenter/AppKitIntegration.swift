//
//  AppKitIntegration.swift
//  GodotApplePlugins
//
//  Created by Miguel de Icaza on 11/15/25.
//

#if canImport(AppKit)
import AppKit

func presentOnTop(_ vc: NSViewController) {
    guard let window = NSApp.keyWindow ?? NSApp.mainWindow else {
        // Fallback: frontmost window if needed
        NSApp.activate(ignoringOtherApps: true)
        return
    }

    window.contentViewController?.presentAsSheet(vc)
}

#endif
