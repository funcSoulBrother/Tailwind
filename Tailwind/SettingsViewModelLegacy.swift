//
//  SettingsViewModelLegacy.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 1/28/26.
//

import Foundation
import SwiftUI

@MainActor
class SettingsViewModelLegacy: ObservableObject {

    let timerState: TimerState
    let notificationViewModel: NotificationViewModel
    @Published var notificationPermissionScreenShowing = false
    @Published var halfwayWarningTextShowing = false
    @AppStorage("HalwayNotificationOption") var selectedHalfwayOption: HalfwayNotificationOption = .off

    init(
        timerState: TimerState,
        notificationViewModel: NotificationViewModel = NotificationViewModel(),
    ) {
        self.timerState = timerState
        self.notificationViewModel = notificationViewModel
    }
    
    func toggleHalfwayNotificationOn(timeRemaining: Int) {
        if self.timerState.timerActive == true {
            self.notificationViewModel.scheduleHalfwayNotificationAlert(timeRemaining: self.timerState.timeRemaining)
        }
    }
    
    func toggleHalfwayNotificationOff() {
        halfwayWarningTextShowing = false
        notificationViewModel.cancelHalfwayNotificationAlert()
    }
    
    func checkNotificationPermissionHalfwayEdition() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            Task { @MainActor in
                switch settings.authorizationStatus {
                case .notDetermined:
                    print("Not determined - requesting permission")
                    self.notificationPermissionScreenShowing = true

                case .authorized:
                    print("Authorized - can schedule notifications")
                    self.halfwayWarningTextShowing = false
                case .denied:
                    print("Denied - prompt user to enable in Settings")
                    self.halfwayWarningTextShowing = true
                case .provisional:
                    print("Provisional authorization")

                case .ephemeral:
                    print("Ephemeral authorization")

                @unknown default:
                    break
                }
            }
        }
    }
    
    func checkNotificationPermissionForHalfwayWarning() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            Task { @MainActor in
                switch settings.authorizationStatus {
                case .notDetermined:
                    print("Not determined - requesting permission")
                case .authorized:
                    print("Authorized - can schedule notifications")
                    self.halfwayWarningTextShowing = false
                case .denied:
                    print("Denied - prompt user to enable in Settings")
                    if self.selectedHalfwayOption == .on {
                        self.halfwayWarningTextShowing = true
                    }
                case .provisional:
                    print("Provisional authorization")

                case .ephemeral:
                    print("Ephemeral authorization")

                @unknown default:
                    break
                }
            }
        }
    }
}
