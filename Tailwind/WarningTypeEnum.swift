//
//  WarningTypeEnum.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 2/14/26.
//

enum WarningType {
    case none, notification, alarm

    var text: String? {
        switch self {
        case .notification:
            return "Notification permission has been denied so you will not see a notification when the cooldown period is over. Tap this message to enable notifications in Settings."
        case .alarm:
            return "Alarm permission has been denied so an alarm won't go off when the cooldown period is over. Tap this message to enable alarms in Settings."
        case .none:
            return nil
        }
    }
}
