//
//  SettingsViewModel.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 1/13/26.
//
import Foundation
import SwiftUI

@available(iOS 26, *)
@MainActor
class SettingsViewModel: ObservableObject {

    let timerState: TimerState
    let notificationViewModel: NotificationViewModel
    let alarmViewModel: AlarmViewModel
    @Published var notificationPermissionScreenShowing = false
    @Published var alarmPermissionScreenShowing = false
    @Published var halfwayWarningTextShowing = false
    @AppStorage("HalwayNotificationOption") var selectedHalfwayOption: HalfwayNotificationOption = .off

    init(
        timerState: TimerState,
        notificationViewModel: NotificationViewModel = NotificationViewModel(),
        alarmViewModel: AlarmViewModel = AlarmViewModel(),
    ) {
        self.timerState = timerState
        self.notificationViewModel = notificationViewModel
        self.alarmViewModel = alarmViewModel
    }
    
    func toggleNotificationOn(currentRound: Int, timeRemaining: Int) {
        //turn off Alarm
        alarmViewModel.cancelCooldownAlarm()
        //request permission if necessary
        checkNotificationPermission()
        //turn on Notification
        if self.timerState.timerActive == true {
            self.notificationViewModel.scheduleNotificationAlert(currentRound: currentRound, timeRemaining: self.timerState.timeRemaining)
        }
    }
    
    func toggleAlarmOn(currentRound: Int, timeRemaining: Int) {
        //turn off Notifications
        notificationViewModel.cancelNotificationAlert()
        //request permission and/or turn on Alarm
        Task {
            await checkAlarmPermissionOrScheduleAlarm(currentRound: currentRound)
        }
    }
    
    func toggleHalfwayNotificationOn(timeRemaining: Int) {
        //request permission if necessary
        checkNotificationPermissionHalfwayEdition()
        
            if self.timerState.timerActive == true {
                self.notificationViewModel.scheduleHalfwayNotificationAlert(timeRemaining: self.timerState.timeRemaining)
            }
    }
    
    func toggleHalfwayNotificationOff() {
        halfwayWarningTextShowing = false
        notificationViewModel.cancelHalfwayNotificationAlert()
    }
    
    func checkNotificationPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            Task { @MainActor in
                switch settings.authorizationStatus {
                case .notDetermined:
                    print("Not determined - requesting permission")
                    self.notificationPermissionScreenShowing = true

                case .authorized:
                    print("Authorized - can schedule notifications")

                case .denied:
                    print("Denied - prompt user to enable in Settings")

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
    
    @available(iOS 26, *)
    @MainActor
    func checkAlarmPermissionOrScheduleAlarm(currentRound: Int) async -> Bool {

        print("requestAlarmAuthorization called, current state: \(alarmViewModel.alarmManager.authorizationState)")

        switch alarmViewModel.alarmManager.authorizationState {

        case .notDetermined:
            print("State is notDetermined, requesting authorization...")
            alarmPermissionScreenShowing = true
            return false

        case .denied:
            print("Authorization denied")
            return false

        case .authorized:
            print("Already authorized")

            if self.timerState.timerActive {
                alarmViewModel.scheduleCooldownAlarm(
                    currentRound: currentRound,
                    timeRemaining: timerState.timeRemaining
                )
            }

            return true

        @unknown default:
            print("Unknown authorization state")
            return false
        }
    }
    
}
    

