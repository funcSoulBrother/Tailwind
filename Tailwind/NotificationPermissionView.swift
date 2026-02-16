//
//  notificationPermissionView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 2/9/26.
//

import SwiftUI

struct NotificationPermissionView: View {
    @Environment(\.dismiss) var dismiss
    @State var notificationViewModel = NotificationViewModel()
    @AppStorage("CurrentRound") var currentRound = 1
    @ObservedObject var timerState: TimerState
    
    var body: some View {
        ZStack {
            Color("EasyBG")
                .ignoresSafeArea()
            VStack {
                Image(systemName: "bell.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(Color("ChuTertiary"))
                    .padding(.top, 20)
                Text("Tailwind uses notifications to let you know when a cooldown period is over. If you opt in, they can also be used for halfway reminders to decrease the time it takes to make your buddy excited.")
                    .padding(20)
                VStack(alignment: .center){
                    Button(action: { dismiss()
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                            if granted {
                                notificationViewModel.scheduleNotificationAlert(currentRound: currentRound, timeRemaining: timerState.timeRemaining)
                                print("Permission granted")
                            }
                        }
                    }) {
                        Text("Enable Notifications")
                            .frame(width: 200)
                            .fontWeight(.semibold)
                            .padding()
                            .background(Color("ChuSecondary"))
                            .foregroundColor(Color("EasyBG"))
                            .cornerRadius(10)
                    }
                    Button(action: { dismiss() }) {
                        Text("Not Now")
                            .frame(width: 200)
                            .fontWeight(.semibold)
                            .padding()
                            .background(Color("ChuQuaternary"))
                            .foregroundColor(Color("EasyBG"))
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}
