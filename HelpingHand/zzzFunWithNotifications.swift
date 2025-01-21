//
//  zzzFunWithNotifications.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 1/16/25.
//
import UserNotifications
import SwiftUI

struct FunWithNotifications: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Hey"
                content.subtitle = "Your mom is a fucking whore"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

#Preview {
    FunWithNotifications()
}
