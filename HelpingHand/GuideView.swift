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
        let round1View = Round1View()
        let round2View = Round2View()
        let round3View = Round3View()
        let round4View = Round4View()
        let round5View = Round5View()
        
        ScrollView {
            if currentRound == 1 {
                round1View
            }
            else if currentRound == 2 {
                round2View
            }
            else if currentRound == 3 {
                round3View
            }
            else if currentRound == 4 {
                round4View
            }
            else {
                round5View
            }
        }
    }
}


#Preview {
    GuideView()
}
