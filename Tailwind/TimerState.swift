//
//  TimerState.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/27/25.
//

import SwiftUI
import AlarmKit
import UserNotifications

final class TimerState: ObservableObject {
    
    @AppStorage("CurrentRound") var currentRound = 1
    @AppStorage("CooldownEndOption") var selectedOption: CooldownEndOption = .alarm
    @AppStorage("HalwayNotificationOption") var selectedHalfwayOption: HalfwayNotificationOption = .off
    @CompatibleAppStorage("TimerEndTime") var storedEndTime: Date?
    ///change to 1_800 after testing
    @Published var timeRemaining = 30 // (1_800 for 30 minutes)
    @Published var halfwayTimeRemaining = 15 // (900 for 15 minutes)
    @Published var timerActive = false
    @Published var timerFirstStarted = false
    @Published var startTime: Date?
    @Published var timer: Timer?
    let notificationViewModel = NotificationViewModel()
    
    func startTimerLegacy() {
        timerActive = true
        startTime = Date()
        storedEndTime = startTime!.addingTimeInterval(TimeInterval(timeRemaining))
        
        if timeRemaining > 0 {
            self.notificationViewModel.scheduleNotificationAlert(currentRound: self.currentRound, timeRemaining: self.timeRemaining)
        }
            
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.timerActive = false
            }
        }
        
        if selectedHalfwayOption == .on {
            notificationViewModel.scheduleHalfwayNotificationAlert(timeRemaining: timeRemaining)
        }
    }
    
    @available(iOS 26, *)
    func startTimer26() {
        let alarmViewModel = AlarmViewModel()
        timerActive = true
        startTime = Date()
        storedEndTime = startTime!.addingTimeInterval(TimeInterval(timeRemaining))
        
        if selectedOption == .notification {
            if timeRemaining > 0 {
                self.notificationViewModel.scheduleNotificationAlert(currentRound: self.currentRound, timeRemaining: self.timeRemaining)
            }
        } else {
            if timeRemaining > 0 {
//                Task { @MainActor in
//                    let granted = await alarmViewModel.requestAlarmAuthorization()
//                    print("Permission granted:", granted)
                    ///not scheduling alarms in here anymore due to premature authorization message
//                    if granted {
//                        alarmViewModel.scheduleCooldownAlarm(currentRound: currentRound, timeRemaining: timeRemaining)
//                    }
//                }
            }
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.timerActive = false
            }
        }
        if selectedHalfwayOption == .on {
            notificationViewModel.scheduleHalfwayNotificationAlert(timeRemaining: timeRemaining)
        }
    }
    
    func pauseTimerLegacy() {
        timerActive = false
        timer?.invalidate()
        notificationViewModel.cancelNotificationAlert()
        notificationViewModel.cancelHalfwayNotificationAlert()
    }
    
    @available(iOS 26, *)
    func pauseTimer26() {
        let alarmViewModel = AlarmViewModel()
        timerActive = false
        timer?.invalidate()
        if selectedOption == .notification {
            notificationViewModel.cancelNotificationAlert()
        } else {
            alarmViewModel.cancelCooldownAlarm()
        }
        notificationViewModel.cancelHalfwayNotificationAlert()
    }
    
    func resetTimer() {
        if #available(iOS 26, *) {
            pauseTimer26()
        } else {
            pauseTimerLegacy()
        }
        ///change to 1_800 later
        timeRemaining = 30
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func restoreTimer() {
        if timerActive {
            let timeAppRestored = Date()
            timeRemaining = Int(timeAppRestored.distance(to: storedEndTime ?? Date()))
            if timeRemaining <= 0 {
                timeRemaining = 0
            }
        } else { return }
    }

}
