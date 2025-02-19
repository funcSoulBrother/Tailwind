//
//  ContentView.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 12/22/24.
//

import SwiftUI

struct ContentView: View {
//    static let kLastSelectedTab = "lastSelectedTab"
//    static let kHasOnboarded = "hasOnboarded"
//    
//    @AppStorage(Self.kLastSelectedTab) var savedSelectedTab: Int = 0
//    @AppStorage(Self.kHasOnboarded) private var willOnboardingScreenShow = true
    
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
//            TestView()
            TimerView()
                .tabItem {
                    Label("Step-by-Step Guide", systemImage: "map.fill")
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
        .accentColor(.yellow)
//        .sheet(isPresented: $willOnboardingScreenShow) {
//            OnboardingScreen(willOnboardingScreenShow: $willOnboardingScreenShow)
//                .interactiveDismissDisabled()
//        }
    }
}

//struct TestView: View {
//    var body: some View {
//        Text("Ya it worked?")
//    }
//}

#Preview {
    ContentView()
}
