//
//  Round3View.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 1/26/25.
//

import SwiftUI

struct Round3View: View {
    @AppStorage("CurrentRound") var currentRound = 1
    @State var extraActionsScreenShowing = false
    
    var body: some View {
        let timerView = TimerView()
        
        ScrollView {
            Text("Round \(currentRound)")
                .font(.largeTitle)
                .padding()
            VStack(alignment: .leading) {
                HStack {
                    Text("• Feed your buddy 1 berry (or 3 if you want to gain a Heart)")
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("• Play with your buddy")
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("• Take a picture of your buddy")
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("• Battle a team leader")
                        .fontWeight(.semibold)
                }
                Text("Once you've completed the 4 actions listed above, press the Start button to start the timer. After 30 minutes you'll be able to progress to Round \(currentRound + 1)!")
                    .padding()
            }
            .padding()
            timerView
            Text("Optional: if possible, at any point during the first four rounds, do one of the following extra actions to get your buddy excited in an hour and a half instead of 2 hours:")
                .padding()
            Button("List of Extra Actions") {
                extraActionsScreenShowing = true
            }
            .padding()
            .sheet(isPresented: $extraActionsScreenShowing) {
                ExtraActionsView()
            }
        }
    }
}


#Preview {
    Round3View()
}
