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
    @State var glow = false
    @State var timeRemaining = 30 // Set your countdown time in seconds (1,800 for 30 minutes)
    @State var timerActive = false
    @State var timer: Timer?
    @State var showStartOverAlert = false
    @State var showResetTimerAlert = false
    @State var startTime: Date?
    @State var helpScreenShowing = false
    @AppStorage("CurrentRound") var currentRound = 1
    @AppStorage("TimerEndTime") var storedEndTime: Date?
    
    
    struct Task: Identifiable {
        let id = UUID()
        let name: String
        var isCompleted: Bool
    }
    
    @State var round1Tasks = [
        Task(name: "Feed your buddy a berry (three if you want to gain more Hearts)", isCompleted: false),
        Task(name: "Play with your buddy", isCompleted: false),
        Task(name: "Take a snapshot", isCompleted: false),
        Task(name: "Battle a team leader", isCompleted: false)
    ]
    
    @State var round2Or4Tasks = [
        Task(name: "Feed your buddy one berry", isCompleted: false),
        Task(name: "Play with your buddy", isCompleted: false),
        Task(name: "Take a snapshot", isCompleted: false),
        Task(name: "Battle a team leader", isCompleted: false)
    ]
    
    @State var round3Tasks = [
        Task(name: "Feed your buddy one berry (two if you fed your buddy three berries in Round 1 and you want another Heart)", isCompleted: false),
        Task(name: "Play with your buddy", isCompleted: false),
        Task(name: "Take a snapshot", isCompleted: false),
        Task(name: "Battle a team leader", isCompleted: false)
    ]
    
    @State private var animateTask: UUID? = nil
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Round \(currentRound)")
                    .font(.largeTitle)
                LazyVStack {
                    if currentRound == 1 {
                        ForEach($round1Tasks) { $task in
                            HStack {
                                Text(task.name)
                                Spacer()
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                                    .imageScale(.large)
                                    .scaleEffect(animateTask == task.id ? 1.2 : 1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: animateTask)
                                    .onTapGesture {
                                        task.isCompleted.toggle()
                                        if task.isCompleted {
                                            animateTask = task.id
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                animateTask = nil
                                            }
                                        }
                                    }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    if currentRound == 2 || currentRound == 4 {
                        ForEach($round2Or4Tasks) { $task in
                            HStack {
                                Text(task.name)
                                Spacer()
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                                    .imageScale(.large)
                                    .scaleEffect(animateTask == task.id ? 1.2 : 1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: animateTask)
                                    .onTapGesture {
                                        task.isCompleted.toggle()
                                        if task.isCompleted {
                                            animateTask = task.id
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                animateTask = nil
                                            }
                                        }
                                    }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    if currentRound == 3 {
                        ForEach($round3Tasks) { $task in
                            HStack {
                                Text(task.name)
                                Spacer()
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                                    .imageScale(.large)
                                    .scaleEffect(animateTask == task.id ? 1.2 : 1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: animateTask)
                                    .onTapGesture {
                                        task.isCompleted.toggle()
                                        if task.isCompleted {
                                            animateTask = task.id
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                animateTask = nil
                                            }
                                        }
                                    }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    if currentRound == 5 {
                        VStack {
                            Text("Perform the following tasks until your buddy is excited: (you should only have to do one if you did everything correctly!)")
                                .padding()
                            VStack (alignment: .leading) {
                                Text("• Feed your buddy a berry (two to earn another Heart)")
                                Text("• Play with your buddy")
                                Text("• Take a snapshot")
                                Text("• Battle a team leader")
                            }
                            Text("Next time read the other section to learn how to make this process half an hour shorter. Click the Start from Round 1 button to make another buddy excited!")
                                .padding()
                            
                        }
                    }
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            helpScreenShowing = true
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .imageScale(.large) // Makes it slightly bigger
                        }
                    }
                }
                .sheet(isPresented: $helpScreenShowing) {
                    HowToUseScreenView()
                }
                
                VStack {
                    Text(formatTime(timeRemaining))
                        .contentTransition(.numericText())
                        .animation(.linear, value: timeRemaining)
                        .font(.largeTitle)
                        .padding()
                    
                    
                    if round1Tasks.allSatisfy({ $0.isCompleted }) || round2Or4Tasks.allSatisfy({ $0.isCompleted}) || round3Tasks.allSatisfy({ $0.isCompleted}) {
                        //ACTIVE BUTTONS (AFTER EVERYTHING IS COMPLETED)
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
                        
                    }
                    //INACTIVE BUTTONS
                    else {
                        HStack {
                            Button("Start") {
                                print("This Start button is currently disabled.")
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .foregroundColor(.secondary)
                            .cornerRadius(10)
                            
                            Button("Pause") {
                                print("This Pause button doesn't seem to do anything...")
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .foregroundColor(.secondary)
                            .cornerRadius(10)
                            
                            Button("Reset") {
                                print("This Reset button does nothing lol!")
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .foregroundColor(.secondary)
                            .cornerRadius(10)
                        }
                    }
                    if timeRemaining == 0 {
                        Button("Start Round \(currentRound + 1)") {
                            currentRound += 1
                            print("Round \(currentRound)")
                            resetTimer()
                            resetTasks()
                        }
                        .fontWeight(.semibold)
                        .padding(14)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.8), radius: glow ? 20 : 5, x: 0, y: 0)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                glow.toggle()
                            }
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
        }
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
        resetTasks()
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
    
    func resetTasks() {
        for index in round1Tasks.indices {
            round1Tasks[index].isCompleted = false
        }
        for index in round2Or4Tasks.indices {
            round2Or4Tasks[index].isCompleted = false
        }
        for index in round3Tasks.indices {
            round3Tasks[index].isCompleted = false
        }
        
    }
}
struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
            TimerView()
        .previewLayout(.sizeThatFits)
    }
}
