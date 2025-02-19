//
//  Round4View.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 1/23/25.
//

import SwiftUI

struct Round4View: View {
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
                    Text("• Feed your buddy 3 berries")
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
                Text("Complete the 4 actions above. If you were able to do any of the extra actions, your buddy is excited! If not, press the Start button to start the timer and progress to Round 5 when it's done.")
                    .padding()
            }
            .padding()
            timerView
            Text("Reminder: if possible, complete any of the following extra options to get your buddy excited now!")
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
    Round4View()
}
