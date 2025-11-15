//
//  GodotApplePlugins.swift
//  GodotApplePlugins
//
//  Created by Miguel de Icaza on 11/14/25.
//

import SwiftGodotRuntime

#initSwiftExtension(cdecl: "godot_apple_plugins_start", types: [
    GodotAVAudioSession.self
])
