//
//  BoringDetailsView.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 12/28/24.
//

import SwiftUI

struct BoringDetailsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Excited Mechanics")
            .font(.largeTitle)
            .padding()
        HStack {
            Image(systemName: "circle")
            Text("This app assumes that you're working with the bare minimum (no access to GO Rocket battles, gym battles, no buddy gifts or souvenirs, no ability to get walking hearts). With the bare minimum you'll be able to get your buddy excited in roughly two hours. If you're able to perform one or more of these extra actions you'll be able to get your buddy excited in one and a half hours (or sooner depending on how many extra actions you can perform). ")
        }
        Button("Dismiss that jank!") {
            dismiss()
        }
    }
}

#Preview {
    BoringDetailsView()
}
