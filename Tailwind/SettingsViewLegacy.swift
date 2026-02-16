//
//  SettingsViewLegacy.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 1/28/26.
//

import SwiftUI

struct SettingsViewLegacy: View {
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("CooldownEndOption") var selectedOption: CooldownEndOption = .alarm
    @AppStorage("HalwayNotificationOption") var selectedHalfwayOption: HalfwayNotificationOption = .off
    @AppStorage("CurrentRound") var currentRound = 1
    @State var halfwayTutorialScreenShowing = false
    let optionsHalfway = HalfwayNotificationOption.allCases
    @StateObject var settingsViewModelLegacy: SettingsViewModelLegacy
    init(timerState: TimerState) {
        _settingsViewModelLegacy = StateObject(
            wrappedValue: SettingsViewModelLegacy(timerState: timerState)
        )
    }
    let halfwayWarningText = "Notification permission has been denied so you will not see halfway notifications. Tap this message to enable notifications in Settings."
    
    var body: some View {
        VStack {
            Text("Halfway Notifications")
                .foregroundColor(Color("ChuQuaternary"))
                .font(.largeTitle)
                .padding(.bottom, 25)
                .padding(.horizontal, 20)
                .padding(.top, 50)
            toggleHalfway
            Button("What's This?") {
                halfwayTutorialScreenShowing = true
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 20)
            .padding(.trailing, 20)
            Button(halfwayWarningText) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            .font(.caption2)
            .background(.pink.opacity(0.0001))
            .opacity(settingsViewModelLegacy.halfwayWarningTextShowing == true ? 1 : 0)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                settingsViewModelLegacy.checkNotificationPermissionForHalfwayWarning()
            }
        }
        .sheet(isPresented: $halfwayTutorialScreenShowing) {
            HalfwayTutorialScreenView()
                .presentationDetents([.height(450), .large])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $settingsViewModelLegacy.notificationPermissionScreenShowing) {
            NotificationPermissionView(timerState: settingsViewModelLegacy.timerState)
                .presentationDetents([.height(450), .large])
                .presentationDragIndicator(.visible)
        }
    }

    private var toggleHalfway: some View {
        HStack {
            ForEach(optionsHalfway) { option in
                Button {
                    Task {
                        selectedHalfwayOption = option
                        if selectedHalfwayOption == .on {
                            settingsViewModelLegacy.checkNotificationPermissionHalfwayEdition()
                            settingsViewModelLegacy.toggleHalfwayNotificationOn(timeRemaining: settingsViewModelLegacy.timerState.timeRemaining)
                        } else {
                            settingsViewModelLegacy.toggleHalfwayNotificationOff()
                        }
                    }
                } label: {
                    VStack {
                            Image(systemName: option.image)
                                .font(.largeTitle)
                                .opacity(selectedHalfwayOption == option ? 1 : 0)
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
}
