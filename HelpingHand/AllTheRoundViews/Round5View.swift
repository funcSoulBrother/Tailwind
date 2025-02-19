//
//  Round5View.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 1/23/25.
//

import SwiftUI

struct Round5View: View {
    @AppStorage("CurrentRound") var currentRound = 1
    @State var extraActionsScreenShowing = false
    
    var body: some View {
        
        ScrollView {
            Text("Round \(currentRound)")
                .font(.largeTitle)
                .padding()
            Text("Complete one of the following actions and your buddy will be excited!")
                Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text("• Feed your buddy 1 berry (or 3 if you want to gain a Heart")
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
                Spacer()
                VStack(alignment: .listRowSeparatorLeading) {
                    Spacer()
                    Button("Start from Round 1") {
                        currentRound = 1
                    }
                    //                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
    }
}


#Preview {
    Round5View()
}
