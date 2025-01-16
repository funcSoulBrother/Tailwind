////
////  TimerViewThree.swift
////  HelpingHand
////
////  Created by Daniel Marsh on 1/11/25.
////
//
//import SwiftUI
//import Observation // Ensure this is imported to use @Observable
//
//@Observable
//class TimerModel {
//    var timeRemaining: Int = 60
//    var timerActive: Bool = false
//    
//    private var timer: Timer?
//    
//    @AppStorage("TimerStartTime") private var storedStartTime: Date?
//    @AppStorage("TimerDuration") private var storedDuration: Int = 0
//
//    func startTimer() {
//        storedStartTime = Date()
//        storedDuration = timeRemaining
//        
//        timerActive = true
//        
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
//            guard let self = self else { return }
//            if self.timeRemaining > 0 {
//                self.timeRemaining -= 1
//            } else {
//                self.stopTimer()
//            }
//        }
//    }
//    
//    func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//        timerActive = false
//        
//        storedStartTime = nil
//        storedDuration = 0
//    }
//    
//    func restoreTimer() {
//        guard let startTime = storedStartTime else {
//            return
//        }
//        
//        let elapsedTime = Int(Date().timeIntervalSince(startTime))
//        let remainingTime = max(0, storedDuration - elapsedTime)
//        
//        timeRemaining = remainingTime
//        timerActive = remainingTime > 0
//        
//        if timerActive {
//            startTimer()
//        }
//    }
//}
//
//struct TimerViewThree: View {
//    @State private var viewModel = TimerModel() // Observing TimerModel
//    
//    var body: some View {
//        VStack {
//            Text("Time Remaining: \(viewModel.timeRemaining) seconds")
//                .font(.largeTitle)
//                .padding()
//            
//            if viewModel.timerActive {
//                Button("Stop Timer") {
//                    viewModel.stopTimer()
//                }
//                .padding()
//            } else {
//                Button("Start Timer") {
//                    viewModel.startTimer()
//                }
//                .padding()
//            }
//        } //After VStack
//        .onAppear {
//            viewModel.restoreTimer()
//        }
//    }
//}
//
//#Preview {
//    TimerViewThree()
//}
//
//
