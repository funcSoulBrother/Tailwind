//
//  ContentView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/22/24.
//

import SwiftUI
import UserNotifications
import AppTrackingTransparency

struct ContentView: View {
    
    @AppStorage("LastSelectedTab") var savedSelectedTab: Int = 0
    @AppStorage("OnboardingScreenShows") private var willOnboardingScreenShow = true
    @AppStorage("CurrentRound") var currentRound = 1
    @StateObject private var buddyTasks = BuddyTasks()
    @StateObject private var timerState = TimerState()
    
    var body: some View {
        TabView(selection: $savedSelectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            GuideView(buddyTasks: buddyTasks, timerState: timerState)
                .tabItem{
                    Label("The Guide", systemImage: "map.fill")
                }
                .tag(1)
            if #available(iOS 26.0, *) {
                SettingsView(timerState: timerState)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(2)
            } else {
                SettingsViewLegacy(timerState: timerState)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
                    .tag(2)
            }
        }
        .onAppear() {
            requestTrackingPermission()
        }

        .accentColor(Color("ChuSecondary"))
        .sheet(isPresented: $willOnboardingScreenShow) {
            OnboardingScreen(willOnboardingScreenShow: $willOnboardingScreenShow)
//                .interactiveDismissDisabled()
        }
    }
    
    func requestTrackingPermission() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if #available(iOS 14, *) {
                    ATTrackingManager.requestTrackingAuthorization { status in
                        switch status {
                        case .authorized:
                            print("Tracking authorization granted")
                        case .denied:
                            print("Tracking authorization denied")
                        case .restricted:
                            print("Tracking restricted")
                        case .notDetermined:
                            print("Tracking not determined")
                        @unknown default:
                            print("Unknown tracking authorization status")
                        }
                    }
                }
            }
        }
    }


#Preview {
    ContentView()
}
