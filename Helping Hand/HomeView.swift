//
//  HomeView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/24/24.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("LastSelectedTab") var savedSelectedTab: Int = 0
    @State var gettingStartedScreenShowing = false
    @State var boringDetailsScreenShowing = false
    
    var body: some View {
        
        VStack (spacing: 50) {
            Rectangle()
                .fill(Color.black)
                .frame(width: 320, height: 200)
            Text("Your one-stop guide to making your buddy excited in Pokémon Go without a poffin!")
                .padding(.horizontal, 14)
            
            HomeButton(title: "The Guide") {
                savedSelectedTab = 1
            }
            
            HomeButton(title: "How to Use") {
                gettingStartedScreenShowing = true
            }
            
            HomeButton(title: "Gritty Details/Tips & Tricks") {
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

struct HomeButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .frame(width: 275)
            .padding()
            .background(Color("ChuPrimary"))
            .foregroundColor(.black)
            .cornerRadius(10)
    }
}


#Preview {
    HomeView()
}
