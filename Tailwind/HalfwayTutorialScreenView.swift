//
//  SwiftUIView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 1/28/26.
//

import SwiftUI

struct HalfwayTutorialScreenView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color("EasyBG")
                .ignoresSafeArea()
            VStack {
                Text("Turn Halfway Notifications on to remind you when the halfway point of each cooldown period happens.")
                    .padding(20)
                Text("These notifications are helpful because if you interact with your buddy once (feed a berry, play, take a snapshot, or battle a team leader) 15 minutes into each 30 minute cooldown period, the excited process will be shortened by 30 minutes. Try it out!")
                    .padding(.horizontal, 25)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Dismiss")
                        .frame(width: 100)
                        .fontWeight(.semibold)
                        .padding()
                        .background(Color("ChuSecondary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 30)
                }
            }
        }
    }
}
