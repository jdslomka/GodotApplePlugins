//
//  GodotAVAudioSession.swift
//  GodotApplePlugins
//
//  Created by Miguel de Icaza on 11/15/25.
//
import SwiftGodotRuntime

extension AVAudioSession {
    public enum SessionCategory: Int64, CaseIterable {
        case ambient
        case multiRoute
        case playAndRecord
        case playback
        case record
        case soloAmbient
        case unknown
    }

    public enum SessionMode: Int64, CaseIterable {
        case `default`
        case gameChat
        case measurement
        case moviePlayback
        case spokenAudio
        case videoChat
        case voiceChat
        case voicePrompt
    }

    public enum RouteSharingPolicy: Int64, CaseIterable {
        case `default`
        case longFormAudio
        case independent
        case longForm
    }
    
    public enum CategoryOptions: Int64, CaseIterable {
        case mixWithOthers = 1
        case duckOthers = 2
        case allowBluetooth = 4
        case defaultToSpeaker = 8
        case interruptSpokenAudioAndMixWithOthers = 17
        case allowBluetoothA2DP = 32
        case allowAirPlay = 64
        case overrideMutedMicrophoneInterruption = 128
    }
}
#if os(iOS) || os(tvOS) || os(visionOS)
import AVFoundation

extension AVAudioSession.SessionCategory {
    func toAVAudioSessionCategory() -> AVFoundation.AVAudioSession.Category {
        switch self {
        case .ambient:
            return .ambient
        case .multiRoute:
            return .multiRoute
        case .playAndRecord:
            return .playAndRecord
        case .playback:
            return .playback
        case .record:
            return .record
        case .soloAmbient:
            return .soloAmbient
        case .unknown:
            return .ambient
        }
    }
}

extension AVAudioSession.SessionMode {
    func toAVAudioSessionMode() -> AVFoundation.AVAudioSession.Mode {
        switch self {
        case .default: return .default
        case .gameChat: return .gameChat
        case .measurement: return .measurement
        case .moviePlayback: return .moviePlayback
        case .spokenAudio: return .spokenAudio
        case .videoChat: return .videoChat
        case .voiceChat: return .voiceChat
        case .voicePrompt: return .voicePrompt
        }
    }
}

extension AVAudioSession.RouteSharingPolicy {
    func toAVAudioSessionRouteSharingPolicy() -> AVFoundation.AVAudioSession.RouteSharingPolicy {
        switch self {
        case .default: return .default
        case .longFormAudio: return .longFormAudio
        case .independent: return .independent
        case .longForm: return .longFormAudio
        }
    }
}

@Godot
public class AVAudioSession: RefCounted, @unchecked Sendable {
    @Export var currentCategory: SessionCategory {
        get {
            switch AVFoundation.AVAudioSession.sharedInstance().category {
            case .ambient:
                return .ambient
            case .multiRoute:
                return .multiRoute
            case .playback:
                return .playback
            case .playAndRecord:
                return .playAndRecord
            case .soloAmbient:
                return .soloAmbient
            default:
                return .unknown
            }
        }
        set {
            try? AVFoundation.AVAudioSession.sharedInstance().setCategory(newValue.toAVAudioSessionCategory())
        }
    }

    @Callable
    public func set_category(category: SessionCategory, mode: SessionMode, policy: RouteSharingPolicy, options: Int64 = 0) -> GodotError {
       do {
           try AVFoundation.AVAudioSession.sharedInstance().setCategory(
               category.toAVAudioSessionCategory(),
               mode: mode.toAVAudioSessionMode(),
               policy: policy.toAVAudioSessionRouteSharingPolicy(),
               options: AVFoundation.AVAudioSession.CategoryOptions(rawValue: UInt(options))
           )
           return .ok
       } catch {
           return .failed
       }
    }
}
#else
@Godot
public class AVAudioSession: RefCounted, @unchecked Sendable {
    @Export var currentCategory: SessionCategory {
        get {
            return .unknown
        }
        set {
            // ignore
        }
    }

    @Callable
    public func set_category(category: SessionCategory, mode: SessionMode, policy: RouteSharingPolicy, options: Int64 = 0) -> GodotError {
        return .ok
    }
}
#endif
