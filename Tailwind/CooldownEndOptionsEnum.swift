//
//  CooldownEndOptionsEnum.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/25/25.
//
import Foundation
import UserNotifications

enum CooldownEndOption: String, CaseIterable, Identifiable {
    case alarm
    case notification
    
    var id: Self { self }
    
    var name: String {
        switch self {
        case .alarm:
            return "Alarm"
        case .notification:
            return "Notification"
        }
    }
    
    var image: String {
        switch self {
        case .alarm:
            return "alarm"
        case .notification:
            return "bell"
        }
    }
}
