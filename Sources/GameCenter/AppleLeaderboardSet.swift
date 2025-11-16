//
//  AppleLeaderboardSets.swift
//  GodotApplePlugins
//
//  Created by Miguel de Icaza on 11/16/25.
//

@preconcurrency import SwiftGodotRuntime
import SwiftUI
#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif
import GameKit

@Godot
class AppleLeaderboardSet: RefCounted, @unchecked Sendable {
    var boardset: GKLeaderboardSet

    required init(_ context: InitContext) {
        boardset = GKLeaderboardSet()
        super.init(context)
    }

    init?(boardset: GKLeaderboardSet) {
        self.boardset = boardset
        guard let ctx = InitContext.createObject(className: AppleLeaderboardSet.godotClassName) else {
            return nil
        }
        super.init(ctx)
    }
}
