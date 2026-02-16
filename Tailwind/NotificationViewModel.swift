//
//  NotificationModel.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 1/13/26.
//

import Foundation
import UserNotifications

struct NotificationViewModel {
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notification permission granted")
                completion(true)
            } else if let error {
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func scheduleNotificationAlert(currentRound: Int, timeRemaining: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Time is Up!"
        content.body = "Round \(currentRound) is done, return to Tailwind to move on to Round \(currentRound + 1)!"
        content.sound = UNNotificationSound.default
            
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeRemaining), repeats: false)
            
        let request = UNNotificationRequest(identifier: "TimerEndNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotificationAlert() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TimerEndNotification"])
    }
    
    func scheduleHalfwayNotificationAlert(timeRemaining: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Halfway Reminder"
        content.body = "Interact with your buddy now to prevent EP decay!"
        content.sound = UNNotificationSound.default
            
        let interval = max(1, timeRemaining - 15)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval), repeats: false)
            
        let request = UNNotificationRequest(identifier: "HalfwayNotification", content: content, trigger: trigger)
            
        if timeRemaining > 15 {
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func cancelHalfwayNotificationAlert() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["HalfwayNotification"])
    }
    
    func notificationPermissionStatus() async -> UNAuthorizationStatus {
        await withCheckedContinuation { continuation in
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                continuation.resume(returning: settings.authorizationStatus)
            }
        }
    }
    
}
