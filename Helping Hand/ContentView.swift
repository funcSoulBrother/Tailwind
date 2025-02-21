//
//  ContentView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/22/24.
//

import SwiftUI

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
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                } else if let error {
                    print(error.localizedDescription)
                }
            }
        }
        .accentColor(Color("ChuSecondary"))
        .sheet(isPresented: $willOnboardingScreenShow) {
            OnboardingScreen(willOnboardingScreenShow: $willOnboardingScreenShow)
                .interactiveDismissDisabled()
        }
    }
}


#Preview {
    ContentView()
}
