//
//  Round1View.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 1/23/25.
//

import SwiftUI

struct Round1View: View {
    @AppStorage("CurrentRound") var currentRound = 1
    @State var extraActionsScreenShowing = false
    
    var body: some View {
        let timerView = TimerView()
        let round1Checklist = Round1ChecklistView()
        
        
        ScrollView {
            Text("Round \(currentRound)")
                .font(.largeTitle)
                .padding()
            VStack {
                round1Checklist
                    .padding()
                timerView
            }

            .padding()
        }
    }
}


#Preview {
    Round1View()
}
