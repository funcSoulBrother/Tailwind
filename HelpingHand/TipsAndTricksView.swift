//
//  TipsAndTricksView.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 12/26/24.
//

import SwiftUI

struct TipsAndTricksView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
//        var tipsAndTricksScreenShowing =  HomeView().$tipsAndTricksScreenShowing
//        @Binding var tipsAndTricksScreenShowing: Bool
        
        
        Text("Tips and Tricks")
            .font(.largeTitle)
            .padding()
        Text("Battles")
            .font(.title)
            .padding()
        HStack {
            Image(systemName: "circle")
            Text("Your buddy needs to be in your battle party but you don't need to win. You can just run first thing and it'll still count.")
        }
        HStack {
            Image(systemName: "circle")
            Text("Each type of battle counts differently. For instance, you can do a GO Rocket battle and then a team leader battle and they'll both count toward increasing excitedness. Only one type of battle per half hour counts, though.")
                .foregroundColor(.gray)
        }
        Button("Dismiss that jank!") {
            dismiss()
        }
    }
}

#Preview {
    TipsAndTricksView()
}
