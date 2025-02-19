//
//  GettingStartedView.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 1/26/25.
//

import SwiftUI

struct GettingStartedView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            Spacer()
            Text("Getting Started")
                .font(.largeTitle)
            Spacer()
            Text("Only doing the bare minimum you’ll be able to get your buddy excited in 2 hours. This guide assumes that you can only do the bare minimum (that is, things that you can do anywhere at any time). This entails 4 half hour rounds of feeding berries, playing, taking pictures, and battling team leaders and one final round of performing 1 or 2 of those actions. However, if you’re able to do one of the following extra actions at any time during the process, your buddy will be excited 30 minutes sooner:")
            Text("• GO Rocket battle")
            Text("• Pvp battle")
            Text("• Gym battle")
            Text("• Raid")
            Text("• Walk 2km")
            Text("• Receive a gift from your buddy")
            Text("• Receive a souvenir from your buddy")
            Text("• Spin a new pokestop")
            Text("Perhaps the easiest of these is the GO Rocket battle. If you can time it so that a Rocket balloon appears during this process you’re good to go.")
            Text("Every action (aside from walking 2km) has a 30-minute cooldown period, which is why this guide has you doing everything in 30-minute rounds. After you're done performing every action in a round, press the Start button for the timer to begin. Once that's finished, a button will appear that will take you to the next round. Excitedness goes down in time, too, so don't wait too long after the timer goes off to start the next round.")
            Text("Also note: for any of the battles to count toward making your buddy excited, your buddy has to be in the battle party. They don't necessarily have to fight and it doesn't matter if it faints. ")
            Text("That's all you need to know to use this guide. Have fun spoiling your buddy!")
            Button("Dismiss that jank!") {
                dismiss()
            }
        }
    }
}

#Preview {
    GettingStartedView()
}
