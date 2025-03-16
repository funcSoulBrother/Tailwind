//
//  TimerView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/22/24.
//
import UserNotifications
import SwiftUI
import StartApp

struct GuideView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.colorScheme) var colorScheme
    @State var isBlinking = false
    @State var timeRemaining = 30 // (1_800 for 30 minutes)
    @State var timerActive = false
    @State var timer: Timer?
    @State var showRound1Alert = false
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
        Task(name: "Battle a team leader", isCompleted: false),
        Task(name: "Take a snapshot", isCompleted: false)
    ]
    
    @State var round2Or4Tasks = [
        Task(name: "Feed your buddy one berry", isCompleted: false),
        Task(name: "Play with your buddy", isCompleted: false),
        Task(name: "Battle a team leader", isCompleted: false),
        Task(name: "Take a snapshot", isCompleted: false)
    ]
    
    @State var round3Tasks = [
        Task(name: "Feed your buddy one berry (two if you fed your buddy three berries in Round 1 and you want another Heart)", isCompleted: false),
        Task(name: "Play with your buddy", isCompleted: false),
        Task(name: "Battle a team leader", isCompleted: false),
        Task(name: "Take a snapshot", isCompleted: false)
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
                                    .foregroundColor(task.isCompleted ? Color("ChuPrimary") : .gray)
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
                                    .foregroundColor(task.isCompleted ? Color("ChuPrimary") : .gray)
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
                                    .foregroundColor(task.isCompleted ? Color("ChuPrimary") : .gray)
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
                            Text("This is the end! Perform the following tasks until your buddy is excited: (you should only have to do one if you did everything correctly)")
                                .padding()
                            VStack (alignment: .leading) {
                                Text("• Feed your buddy a berry (two to earn another Heart)")
                                Text("• Play with your buddy")
                                Text("• Battle a team leader")
                                Text("• Take a snapshot")
                            }
                            Text("It's possible to make your buddy excited in Round 4; read how in the Gritty Details section. Click the Start from Round 1 button to make another buddy excited!")
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
                                .imageScale(.large)
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
                    
                    if timeRemaining != 0 {
                        if round1Tasks.allSatisfy({ $0.isCompleted }) || round2Or4Tasks.allSatisfy({ $0.isCompleted}) || round3Tasks.allSatisfy({ $0.isCompleted}) {
                            //ACTIVE BUTTONS (AFTER EVERYTHING IS COMPLETED)
                            HStack {
                                Button(action: startTimer) {
                                    Text("Start")
                                        .padding()
                                        .background(Color("ChuSecondary"))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                .disabled(timerActive)
                                
                                Button(action: pauseTimer) {
                                    Text("Pause")
                                        .padding()
                                        .background(Color("ChuTertiary"))
                                        .foregroundColor(colorScheme == .dark ? .black : .white)
                                        .cornerRadius(10)
                                }
                                .disabled(!timerActive)
                                
                                Button("Reset") {
                                    showResetTimerAlert = true
                                }
                                .padding()
                                .background(Color("ChuQuaternary"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .alert("Reset?", isPresented: $showResetTimerAlert) {
                                    Button("No", role: .cancel) {}
                                    Button("Yes I'm sure") {
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
                        .background(isBlinking ? Color(Color("ChuSecondary")) : Color("ChuQuaternary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onAppear {
                            startBlinking()
                        }
                    }
                    if currentRound == 1 {
                        Button("Start from Round 1") {
                            showRound1Alert = true
                        }
                        .padding()
                        .background(Color("ChuPrimary"))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .alert("Uh, it's already Round 1.", isPresented: $showRound1Alert) {
                            Button("Oh, I knew that...", role: .cancel) {}
                        }
                    } else if currentRound == 2 || currentRound == 3 || currentRound == 4 {
                        Button("Start from Round 1") {
                            showStartOverAlert = true
                        }
                        .padding()
                        .background(Color("ChuPrimary"))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .alert("Start Over?", isPresented: $showStartOverAlert) {
                            Button("No", role: .cancel) {}
                            Button("Yes I'm sure") {
                                startOver()
                            }
                        } message: {
                            Text("Are you sure you want to reset any progress and start from Round 1?")
                        }
                    } else {
                        Button("Start from Round 1") {
                            startOver()
                        }
                        .padding()
                        .background(Color("ChuPrimary"))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                    
                    StartAppBanner()
                        .frame(height: 50)
                        .background(Color(UIColor.secondarySystemBackground))
                    
                }
                .onChange(of: scenePhase) { oldPhase, newPhase in
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
    
    private func startBlinking() {
        withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
            isBlinking.toggle()
        }
    }
}

struct StartAppBanner: UIViewRepresentable {
    func makeUIView(context: Context) -> STABannerView {
        // Create a default UIView to return if banner creation fails
        let defaultView = STABannerView()
        
        // Try to create the banner with safe unwrapping
        if let banner = STABannerView(size: STA_AutoAdSize,
                                    origin: CGPoint(x: 0, y: 0),
                                    withDelegate: context.coordinator) {
            banner.loadAd()
            return banner
        } else {
            print("Failed to create STABannerView")
            return defaultView
        }
    }
    
    func updateUIView(_ uiView: STABannerView, context: Context) {
        // Updates if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, STABannerDelegateProtocol {
        func didDisplayBannerAd(_ banner: STABannerView) {
            print("Banner ad displayed")
        }
        
        func failedLoadBannerAd(_ banner: STABannerView, withError error: Error) {
            print("Failed to load banner ad: \(error.localizedDescription)")
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
            GuideView()
        .previewLayout(.sizeThatFits)
    }
}
