//
//  HomeView.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 12/24/24.
//

import SwiftUI

struct HomeView: View {
//    var selectedTab = ContentView.savedSelectedTab
    @AppStorage("LastSelectedTab") var savedSelectedTab: Int = 0
    @State var gettingStartedScreenShowing = false
    @State var boringDetailsScreenShowing = false
    
    var body: some View {
        
        VStack (spacing: 50) {
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 320, height: 200)
            Text("Your step-by-step guide to making your buddy excited in Pokémon Go without a poffin!")
                .padding(.horizontal, 14)
            Button("The Guide") {
                savedSelectedTab = 1
            }
            Button("How to Use") {
                gettingStartedScreenShowing = true
            }
            Button("Gritty Details/Tips & Tricks") {
                boringDetailsScreenShowing = true
            }
            
        }
        .sheet(isPresented: $gettingStartedScreenShowing) {
            HowToUseScreenView()
        }
        .sheet(isPresented: $boringDetailsScreenShowing) {
            GrittyDetailsScreenView()
        }
    }
}


#Preview {
    HomeView()
}
