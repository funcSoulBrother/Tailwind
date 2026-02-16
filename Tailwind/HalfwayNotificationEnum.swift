//
//  HalfwayNotificationEnum.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 1/27/26.
//

import Foundation
import UserNotifications

enum HalfwayNotificationOption: String, CaseIterable, Identifiable {
    case on
    case off
    
    var id: Self { self }
    
    var name: String {
        switch self {
        case .on:
            return "On"
        case .off:
            return "Off"
        }
    }
    
    var image: String {
        switch self {
        case .on:
            return "lightswitch.on"
        case .off:
            return "lightswitch.off"
        }
    }
}
