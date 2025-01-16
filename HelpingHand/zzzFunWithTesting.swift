//
//  zzzFunWithTesting.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 1/13/25.
//

import SwiftUI

struct FunWithTesting: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var currentDate = Date()
    
    var body: some View {
        @State var currentDatePlusHalfHour = currentDate.addingTimeInterval(1_800)
        @State var message: String = "Waiting for scene phase change..."
        @State var sceneMessage: String = "Nothing happened yet, dern!"

        
        VStack(spacing: 20) {
            // Display the current date
            Text("Current Date:")
                .font(.headline)
            Text(currentDate.formatted(.dateTime.year().month().day().hour().minute().second()))
                .font(.title2)
            Text(currentDatePlusHalfHour.formatted(.dateTime.year().month().day().hour().minute().second()))
                .font(.title2)
            Text("\(sceneMessage)")
            
            // Button to reload the date
            Button(action: {
                // Update the date
                currentDate = Date()
            }) {
                Text("Reload Date")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
                sceneMessage = "inactive, y'all!"
            } else if newPhase == .active {
                print("Active")
                sceneMessage = "this ain't a scene it's an app"
            } else if newPhase == .background {
                print("Background")
                sceneMessage = "I'm in the background, mah dudes"
            }
        }
        .onAppear {
            sceneMessage = "ok active"
        }
        .onDisappear {
            sceneMessage = "ok inactive"
        }
        .padding()
    }
}

#Preview {
    FunWithTesting()
}
