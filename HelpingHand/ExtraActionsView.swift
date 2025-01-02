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
                Image(systemName: "circle")
                Text("Participate in a GO Rocket battle")
            }
            HStack {
                Image(systemName: "circle")
                Text("Earn a heart walking with your buddy")
            }
            HStack {
                Image(systemName: "circle")
                Text("Visit a new place with your buddy")
            }
            HStack {
                Image(systemName: "circle")
                Text("Follow a route with your buddy")
            }
            HStack {
                Image(systemName: "circle")
                Text("Receive a gift from your buddy")
            }
            HStack {
                Image(systemName: "circle")
                Text("Receive a souvenir from your buddy")
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
