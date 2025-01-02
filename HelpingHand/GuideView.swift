//
//  GuideView.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 12/24/24.
//

import SwiftUI

struct GuideView: View {
    @AppStorage("CurrentRound") var currentRound = 1
    @State var extraActionsScreenShowing = false
   
    var body: some View {
        let timerView = TimerView()
        
        if currentRound < 4 {
            Text("Round \(currentRound)")
                .font(.largeTitle)
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "circle")
                    Text("Feed your buddy 3 berries")
                }
                HStack {
                    Image(systemName: "circle")
                    Text("Play with your buddy")
                }
                HStack {
                    Image(systemName: "circle")
                    Text("Take a picture of your buddy")
                }
                HStack {
                    Image(systemName: "circle")
                    Text("Battle a team leader")
                }
                Text("Optional: if possible, perform one of the following extra actions to make your buddy excited half an hour sooner:")
            }
            Button("List of Extra Actions") {
                extraActionsScreenShowing = true
            }
            .padding()
            .sheet(isPresented: $extraActionsScreenShowing) {
                ExtraActionsView()
            }
            timerView
        }
        else if currentRound == 4 {
            Text("Round \(currentRound)")
                .font(.largeTitle)
            Text("It's Round 4, boiiiii!!!!!!")
            timerView
        }
        else {
            Text("Round \(currentRound)")
                .font(.largeTitle)
            Text("Wow that's a whole lotta rounds!")
            timerView
        }
    }
}


#Preview {
    GuideView()
}
