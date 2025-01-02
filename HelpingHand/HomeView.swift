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
    @State var tipsAndTricksScreenShowing = false
    @State var boringDetailsScreenShowing = false
    
    var body: some View {
        
        VStack (spacing: 50) {
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 320, height: 200)
            Text("Your step-by-step guide to making your buddy excited in Pokémon Go without a poffin!")
                .padding(.horizontal, 14)
            Button("Step-by-Step Guide") {
                savedSelectedTab = 1
            }
            Button("Tips and Tricks") {
                tipsAndTricksScreenShowing = true
            }
            Button("Boring Details") {
                boringDetailsScreenShowing = true
            }
            
        }
        .sheet(isPresented: $tipsAndTricksScreenShowing) {
            TipsAndTricksView()
        }
        .sheet(isPresented: $boringDetailsScreenShowing) {
            BoringDetailsView()
        }
    }
}


#Preview {
    HomeView()
}
