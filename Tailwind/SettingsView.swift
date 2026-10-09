//
//  SettingsView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/25/25.
//

import SwiftUI

@available(iOS 26, *)
struct SettingsView: View {
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("CooldownEndOption") var selectedOption: CooldownEndOption = .alarm
    @AppStorage("HalwayNotificationOption") var selectedHalfwayOption: HalfwayNotificationOption = .off
    @AppStorage("CurrentRound") var currentRound = 1
    @AppStorage("TimerButtonAlwaysTappableOption") var selectedTimerButtonTappableOption: TimerButtonAlwaysTappable = .no
    @State var halfwayTutorialScreenShowing = false
    let halfwayWarningText = "Notification permission has been denied so you will not see halfway notifications. Tap this message to enable notifications in Settings."
    let options = CooldownEndOption.allCases
    let optionsHalfway = HalfwayNotificationOption.allCases
    let optionsTimerButtonTappable = TimerButtonAlwaysTappable.allCases
    @StateObject var settingsViewModel: SettingsViewModel
    init(timerState: TimerState) {
        _settingsViewModel = StateObject(
            wrappedValue: SettingsViewModel(timerState: timerState)
        )
    }
    
    var body: some View {
        VStack {
            Text("Cooldown End Alert Type")
                .foregroundColor(Color("ChuQuaternary"))
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.bottom, 25)
                .padding(.horizontal, 30)
            toggle
            Text("Halfway Notifications")
                .foregroundColor(Color("ChuQuaternary"))
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.bottom, 25)
                .padding(.horizontal, 30)
                .padding(.top, 55)
            toggleHalfway
            Button("What's This?") {
                halfwayTutorialScreenShowing = true
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            Button(halfwayWarningText) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            .font(.caption2)
            .background(.pink.opacity(0.0001))
            .opacity(settingsViewModel.halfwayWarningTextShowing == true ? 1 : 0)
            Text("Timer Button Always Tappable")
                .foregroundColor(Color("ChuQuaternary"))
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.bottom, 25)
                .padding(.leading, 30)
            toggleTimerButtonTappable
//            Spacer()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                settingsViewModel.checkNotificationPermissionForHalfwayWarning()
            }
        }
        .sheet(isPresented: $halfwayTutorialScreenShowing) {
            HalfwayTutorialScreenView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $settingsViewModel.notificationPermissionScreenShowing) {
            NotificationPermissionView(timerState: settingsViewModel.timerState)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $settingsViewModel.alarmPermissionScreenShowing) {
            AlarmPermissionView(timerState: settingsViewModel.timerState)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    
    private var toggle: some View {
        HStack {
            ForEach(options) { option in
                Button {
                    Task {
                        selectedOption = option
                        if selectedOption == .notification {
                            settingsViewModel.toggleNotificationOn(currentRound: currentRound, timeRemaining: settingsViewModel.timerState.timeRemaining)
                        } else {
                            settingsViewModel.toggleAlarmOn(currentRound: currentRound, timeRemaining: settingsViewModel.timerState.timeRemaining)
                        }
                    }
                } label: {
                    VStack {
                        Image(systemName: option.image)
                            .symbolEffect(.drawOn.individually, isActive: selectedOption != option)
                            .font(.largeTitle)
                        Text(option.name)
                    }
                    .padding()
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(
                        selectedOption == option ? .white : .secondary
                    )
                    .background(
                        selectedOption == option ? Color("ChuSecondary") : Color.gray.opacity(0.2)
                    )
                    .cornerRadius(10)
                }
            }
        }
        .padding(.horizontal, 30)
    }
    
    private var toggleHalfway: some View {
        HStack {
            ForEach(optionsHalfway) { option in
                Button {
                    Task {
                        selectedHalfwayOption = option
                        if selectedHalfwayOption == .on {
                            settingsViewModel.checkNotificationPermissionHalfwayEdition()
                            settingsViewModel.toggleHalfwayNotificationOn(timeRemaining: settingsViewModel.timerState.timeRemaining)
                        } else {
                            settingsViewModel.toggleHalfwayNotificationOff()
                        }
                    }
                } label: {
                    VStack {
                        Image(systemName: option.image)
                            .symbolEffect(.drawOn.individually, isActive: selectedHalfwayOption != option)
                            .font(.largeTitle)
                        Text(option.name)
                    }
                    .padding()
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(
                        selectedHalfwayOption == option ? .white : .secondary
                    )
                    .background(
                        selectedHalfwayOption == option ? Color("ChuSecondary") : Color.gray.opacity(0.2)
                    )
                    .cornerRadius(10)
                }
            }
        }
        .padding(.horizontal, 30)
    }
    
    private var toggleTimerButtonTappable: some View {
        HStack {
            ForEach(optionsTimerButtonTappable) { option in
                Button {
                    Task {
                        selectedTimerButtonTappableOption = option
                        if selectedTimerButtonTappableOption == .yes {
                            //nothing needed in here
                        } else {
                            //nothing needed in here either
                        }
                    }
                } label: {
                    VStack {
                        Image(systemName: option.image)
                            .symbolEffect(.drawOn.individually, isActive: selectedTimerButtonTappableOption != option)
                            .font(.largeTitle)
                        Text(option.name)
                    }
                    .padding()
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(
                        selectedTimerButtonTappableOption == option ? .white : .secondary
                    )
                    .background(
                        selectedTimerButtonTappableOption == option ? Color("ChuSecondary") : Color.gray.opacity(0.2)
                    )
                    .cornerRadius(10)
                }
            }
        }
        .padding(.horizontal, 30)
    }
}


//#Preview {
//    SettingsView()
//}
