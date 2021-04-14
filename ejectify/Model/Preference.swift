//
//  Option.swift
//  Ejectify
//
//  Created by Niels Mouthaan on 27/11/2020.
//

import Foundation
import LaunchAtLogin

class Preference {
    
    enum UnmountWhen: String {
        case screensaverStarted = "screensaverStarted"
        case screenIsLocked = "screenIsLocked"
        case screensStartedSleeping = "screensStartedSleeping"
        case systemStartsSleeping = "systemStartsSleeping"
        case never = "never"
    }
    
    static var launchAtLogin: Bool {
        get {
            return LaunchAtLogin.isEnabled
        }
        set {
            LaunchAtLogin.isEnabled = newValue
        }
    }
    
    private static var userDefaultsKeyUnmountWhen = "preference.unmountWhen"
    static var unmountWhen: UnmountWhen {
        get {
            if let rawValue = UserDefaults.standard.string(forKey: userDefaultsKeyUnmountWhen) {
                if let value = UnmountWhen(rawValue: rawValue) {
                    return value
                }
            }
            return .systemStartsSleeping // Default
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: userDefaultsKeyUnmountWhen)
            UserDefaults.standard.synchronize()
            AppDelegate.shared.activityController?.startMonitoring()
        }
    }
}
