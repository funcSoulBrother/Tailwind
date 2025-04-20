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
    
    var body: some View {
        TabView(selection: $savedSelectedTab) {
            HomeView()
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            GuideView()
                .tabItem {
                    Label("The Guide", systemImage: "map.fill")
                }
                .tag(1)
        }
        .onAppear() {
            requestPermissions()
        }

        .accentColor(Color("ChuSecondary"))
        .sheet(isPresented: $willOnboardingScreenShow) {
            OnboardingScreen(willOnboardingScreenShow: $willOnboardingScreenShow)
//                .interactiveDismissDisabled()
        }
    }
    func requestPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notification permission granted")
            } else if let error {
                print(error.localizedDescription)
            }
            
            // After notification permission flow completes (regardless of result),
            // request tracking permission on the main thread with a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
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
}


#Preview {
    ContentView()
}
