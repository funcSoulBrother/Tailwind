//
//  AlarmPermissionView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 2/9/26.
//

import SwiftUI

@available(iOS 26, *)
struct AlarmPermissionView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("CurrentRound") var currentRound = 1
    @ObservedObject var timerState: TimerState
    @State var alarmViewModel = AlarmViewModel()
    
    var body: some View {
        ZStack {
            Color("EasyBG")
                .ignoresSafeArea()
            VStack {
                Image(systemName: "alarm.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(Color("ChuTertiary"))
                    .padding(.top, 20)
                Text("Tailwind uses alarms to let you know when a cooldown period is over.")
                    .padding(20)
                VStack(alignment: .center) {
                    Button {
                        dismiss()
                        Task {
                            let granted = await alarmViewModel.requestAlarmAuthorization()
                            
                            guard granted else {
                                return
                            }
                            alarmViewModel.scheduleCooldownAlarm(currentRound: currentRound, timeRemaining: timerState.timeRemaining)
                        }
                    } label: {
                        Text("Enable Alarms")
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
