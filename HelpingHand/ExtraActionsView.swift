//
//  ExtraActionsView.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 12/31/24.
//

import SwiftUI

struct ExtraActionsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Extra Actions")
            .font(.title)
            .padding()
        VStack(alignment: .leading){
            HStack {
                Text("• Participate in a GO Rocket battle")
            }
            HStack {
                Text("• Earn a heart walking with your buddy")
            }
            HStack {
                Text("• Visit a new place with your buddy")
            }
            HStack {
                Text("• Follow a route with your buddy")
            }
            HStack {
                Text("• Receive a gift from your buddy")
            }
            HStack {
                Text("• Receive a souvenir from your buddy")
            }
        }
        Button("Got it, now get out of my face.") {
            dismiss()
        }
        .padding()
    }
}

#Preview {
    ExtraActionsView()
}
