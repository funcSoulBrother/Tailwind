//
//  TimerView.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 12/22/24.
//
import UserNotifications
import SwiftUI

struct TimerView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var timeRemaining = 30 // Set your countdown time in seconds (1,800 for 30 minutes)
    @State private var timerActive = false
    @State private var timer: Timer?
    @State private var showStartOverAlert = false
    @State private var showResetTimerAlert = false
    @State private var startTime: Date?
    @AppStorage("CurrentRound") var currentRound = 1
    @AppStorage("TimerEndTime") var storedEndTime: Date?

    var body: some View {
        VStack {
            Text(formatTime(timeRemaining))
                .contentTransition(.numericText())
                .animation(.linear, value: timeRemaining)
                .font(.largeTitle)
                .padding()

            HStack {
                Button(action: startTimer) {
                    Text("Start")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(timerActive)

                Button(action: pauseTimer) {
                    Text("Pause")
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(!timerActive)

//                Button(action: resetTimer) {
//                    Text("Reset")
                Button("Reset") {
                    showResetTimerAlert = true
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .alert("Reset?", isPresented: $showResetTimerAlert) {
                            Button("No", role: .cancel) {}
                            Button("Yes I'm sure, sucka.") {
                                resetTimer()
                            }
                        } message: {
                            Text("Are you sure you want to reset the timer back to 30 minutes?")
                        }

            }
            if timeRemaining == 0 {
                Button("Go to Next Round") {
                    currentRound += 1
                    print("Round \(currentRound)")
                    resetTimer()
                }
            }
            Button("Start from Round 1") {
                showStartOverAlert = true
            }
            .padding()
            .background(Color.brown)
            .foregroundColor(.white)
            .cornerRadius(10)
            .alert("Start Over?", isPresented: $showStartOverAlert) {
                        Button("No", role: .cancel) {}
                        Button("Yes I'm sure, fool.") {
                            startOver()
                        }
                    } message: {
                        Text("Are you sure you want to reset any progress and start from round 1?")
                    }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active {
                print("Active")
                restoreTimer()
            } else if newPhase == .background {
                print("Background")
            }
        }
        .padding()
    }
     

    func startTimer() {
        timerActive = true
        startTime = Date()
        storedEndTime = startTime!.addingTimeInterval(TimeInterval(timeRemaining))
        
        if timeRemaining > 0 {
            let content = UNMutableNotificationContent()
            content.title = "Time is Up!"
            content.body = "Round \(currentRound) is done, return to Helping Hand to move on to Round \(currentRound + 1)!"
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeRemaining), repeats: false)
            
            let request = UNNotificationRequest(identifier: "TimerEndNotification", content: content, trigger: trigger)
            
                UNUserNotificationCenter.current().add(request)
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timerActive = false
            }
        }
    }

    func pauseTimer() {
        timerActive = false
        timer?.invalidate()
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TimerEndNotification"])
    }

    func resetTimer() {
        pauseTimer()
        timeRemaining = 30
    }

    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startOver() {
        currentRound = 1
        resetTimer()
    }
    
    func restoreTimer() {
        if timerActive {
            let timeAppRestored = Date()
            timeRemaining = Int(timeAppRestored.distance(to: storedEndTime ?? Date()))
            if timeRemaining <= 0 {
                timeRemaining = 0
            }
        } else { return }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
