//
//  PersistingTimerView.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 12/29/24.
//

import SwiftUI

struct PersistingTimerView: View {
    @State private var remainingTime: Int = 30 // Total countdown in seconds
    @State private var endTime: Date?
    @State private var isTimerActive = false

    var body: some View {
        VStack {
            Text("\(remainingTime / 60):\(String(format: "%02d", remainingTime % 60))")
                .font(.largeTitle)

            Button(isTimerActive ? "Pause" : "Start") {
                if isTimerActive {
                    pauseTimer()
                } else {
                    startTimer()
                }
            }
        }
        .onAppear {
            resumeTimer()
        }
    }

    func startTimer() {
        endTime = Date().addingTimeInterval(TimeInterval(remainingTime))
        isTimerActive = true
    }

    func pauseTimer() {
        if let endTime = endTime {
            remainingTime = max(0, Int(endTime.timeIntervalSinceNow))
        }
        isTimerActive = false
    }

    func resumeTimer() {
        guard let endTime = endTime else { return }
        remainingTime = max(0, Int(endTime.timeIntervalSinceNow))
        isTimerActive = true
    }
}

#Preview {
    PersistingTimerView()
}

