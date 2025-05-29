//
//  TimerView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/22/24.
//
import UserNotifications
import SwiftUI
import StartApp
import StepperView

struct GuideView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.colorScheme) var colorScheme
    @State var isBlinking = false
    @State var timeRemaining = 1_800 // (1_800 for 30 minutes)
    @State var timerActive = false
    @State var timer: Timer?
    @State var showRound1Alert = false
    @State var showStartOverAlert = false
    @State var showResetTimerAlert = false
    @State var startTime: Date?
    @State var helpScreenShowing = false
    @State var timerFirstStarted = false
    @AppStorage("CurrentRound") var currentRound = 1
    @AppStorage("CurrentStep") var currentStep = 1
    @CompatibleAppStorage("TimerEndTime") var storedEndTime: Date?
    
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
    @State private var currentStepperStep = 0
    let stepCount = 5
    
    //next two functions for stepper
    private func indicator(for index: Int) -> some View {
        ZStack {
            if index < currentStepperStep {
                // Completed step
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 30))
            } else if index == currentStepperStep {
                // Current step
                Image(systemName: "\(index + 1).circle.fill")
                    .foregroundColor(Color("ChuSecondary"))
                    .font(.system(size: 30))
            } else {
                // Future step
                Image(systemName: "\(index + 1).circle")
                    .foregroundColor(Color("ChuTertiary"))
                    .font(.system(size: 30))
            }
        }
        .frame(width: 30, height: 30)
    }
    
    // Line view between indicators
    private func lineView(_ isCompleted: Bool) -> some View {
        Rectangle()
            .fill(isCompleted ? Color.green : Color("ChuTertiary"))
            .frame(width: 40, height: 2)
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("EasyBG")
                    .ignoresSafeArea()
                VStack {
                    Text("Round \(currentRound)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    if currentRound != 5 {
                        //Begin Stepper Code
                        HStack(spacing: 0) {
                            ForEach(0..<stepCount, id: \.self) { index in

                                indicator(for: index)
                                
                                if index < stepCount - 1 {
                                    lineView(index < currentStepperStep)
                                }
                            }
                        }
                        //End Stepper Code
                    }
                    if currentStep == 1 { // Beginning of Step 1 (Tasks)
                        LazyVStack {
                            if currentRound <= 4 {
                                Text("Complete the following tasks with your buddy in Pokémon Go. After each task is completed and checked off, the Cool-down button will be enabled.")
                                    .fontWeight(.semibold)
                            }
                            if currentRound == 1 {
                                ForEach($round1Tasks) { $task in
                                    HStack {
                                        Text(task.name)
                                        Spacer()
                                        Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                                            .foregroundColor(task.isCompleted ? Color("ChuTertiary") : .gray)
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
                                    .padding(.trailing, 20)
                                }
                            }
                            if currentRound == 2 || currentRound == 4 {
                                ForEach($round2Or4Tasks) { $task in
                                    HStack {
                                        Text(task.name)
                                        Spacer()
                                        Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                                            .foregroundColor(task.isCompleted ? Color("ChuTertiary") : .gray)
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
                                    .padding(.trailing, 20)
                                }
                            }
                            if currentRound == 3 {
                                ForEach($round3Tasks) { $task in
                                    HStack {
                                        Text(task.name)
                                        Spacer()
                                        Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                                            .foregroundColor(task.isCompleted ? Color("ChuTertiary") : .gray)
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
                                    .padding(.trailing, 20)
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
                                    Text("It's possible to make your buddy excited in Round 4; read how in the Mechanics section. Tap the \"Restart Process\" button to make another buddy excited!")
                                        .padding()
                                }
                            }
                        }
                        .padding()
                        
                        if round1Tasks.allSatisfy({ $0.isCompleted }) || round2Or4Tasks.allSatisfy({ $0.isCompleted}) || round3Tasks.allSatisfy({ $0.isCompleted}) {
                            if #available (iOS 17.0, *) {
                                Button("Start Cool-down Timer") {
                                    currentStep = 2
                                }
                                .fontWeight(.semibold)
                                .padding(14)
                                .background(isBlinking ? Color(Color("ChuSecondary")) : Color("ChuQuaternary"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .onAppear {
                                    startBlinking()
                                }
                            } else {
                                Button("Start Cool-down Timer") {
                                    currentStep = 2
                                    print("Step \(currentStep)")
                                }
                                .fontWeight(.semibold)
                                .padding(14)
                                .background(Color("ChuQuaternary"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .onAppear {
                                    startBlinking()
                                }
                            }
                        } else {
                            if currentRound != 5 {
                                Button("Start Cool-down Timer") {
                                    print("This button is disabled.")
                                }
                                .fontWeight(.semibold)
                                .padding(14)
                                .background(Color(UIColor.secondarySystemBackground))
                                .foregroundColor(.secondary)
                                .cornerRadius(10)
                            }
                        }
                    } else { //Step 1 zone over, Step 2 zone begins (Cool-down)
                        VStack {
                            Text("Wait 30 minutes for the cool-down period before you start Round \(currentRound + 1).")
                                .fontWeight(.semibold)
                                .padding()
                            if currentRound <= 4 {
                                Text(formatTime(timeRemaining))
                                    .contentTransition(.numericText())
                                    .animation(.linear, value: timeRemaining)
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .padding()
                                
                                ZStack { //just to keep everything neatly in place when next round button appears
                                    if timeRemaining != 0 {
                                        HStack {
                                            Spacer().frame(width: 80)
                                            if timerActive == false {
                                                VStack {
                                                    Button(action: {
                                                        startTimer()
                                                    }) {
                                                        Image(systemName: "play.circle.fill")
                                                            .font(.system(size: 70))
                                                            .fontWeight(.bold)
                                                            .foregroundColor(Color("ChuSecondary"))
                                                            .padding()
                                                    }
                                                    Button(action: {
                                                        startTimer()
                                                    }) {
                                                        Text("Start Timer")
                                                            .foregroundColor(Color("ChuSecondary"))
                                                    }
                                                }
                                            } else {
                                                VStack {
                                                    Button(action: {
                                                        pauseTimer()
                                                    }) {
                                                        Image(systemName: "pause.circle.fill")
                                                            .foregroundColor(Color("ChuSecondary"))
                                                            .font(.system(size: 70))
                                                            .fontWeight(.bold)
                                                            .padding()
                                                    }
                                                    Button(action: {
                                                        pauseTimer()
                                                    }) {
                                                        Text("Pause Timer")
                                                            .foregroundColor(Color("ChuSecondary"))
                                                    }
                                                }
                                            }
                                            VStack {
                                                Button(action: {
                                                    showResetTimerAlert = true
                                                }) {
                                                    Image(systemName: "arrow.counterclockwise.circle.fill")
                                                        .font(.largeTitle)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(Color("ChuTertiary"))
                                                        .padding()
                                                        .alert("Reset?", isPresented: $showResetTimerAlert) {
                                                            Button("No", role: .cancel) {}
                                                            Button("Yes I'm sure") {
                                                                resetTimer()
                                                            }
                                                        } message: {
                                                            Text("Are you sure you want to reset the timer back to 30 minutes?")
                                                        }
                                                }
                                                Button(action: {
                                                    resetTimer()
                                                }) {
                                                    Text("Reset Timer")
                                                        .foregroundColor(Color("ChuTertiary"))
                                                        .font(.system(size: 15))
                                                }
                                            }
                                        }
                                    }
                                    if timeRemaining == 0 {
                                        if #available (iOS 17.0, *) {
                                            Button("Start Round \(currentRound + 1)") {
                                                currentRound += 1
                                                currentStep = 1
                                                currentStepperStep += 1
                                                timerFirstStarted = false
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
                                        } else {
                                            Button("Start Round \(currentRound + 1)") {
                                                currentRound += 1
                                                currentStep = 1
                                                currentStepperStep += 1
                                                timerFirstStarted = false
                                                resetTimer()
                                                resetTasks()
                                            }
                                            .fontWeight(.semibold)
                                            .padding(14)
                                            .background(Color("ChuQuaternary"))
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                            .onAppear {
                                                startBlinking()
                                            }
                                        }
                                    }
                                }
                                .frame(width: 300, height: 145)
                            }
                        }
                        .onAppear() {
                            if currentStep != 1 {
                                if !timerActive {
                                    if !timerFirstStarted {
                                        startTimer()
                                        timerFirstStarted = true
                                    }
                                }
                            }
                        }
                        .onChange(of: scenePhase) { phase in
                            if phase == .inactive {
                                print("Inactive")
                            } else if phase == .active {
                                print("Active")
                                restoreTimer()
                            } else if phase == .background {
                                print("Background")
                            }
                        }
                    }
                    
                    if currentRound == 2 || currentRound == 3 || currentRound == 4 || currentStep == 2 {
                        VStack(alignment: .leading) {
                            Button("Restart Process") {
                                showStartOverAlert = true
                            }
                            .padding()
                            .foregroundColor(Color("ChuPrimary"))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .alert("Start Over?", isPresented: $showStartOverAlert) {
                                Button("No", role: .cancel) {}
                                Button("Yes I'm sure") {
                                    startOver()
                                }
                            } message: {
                                Text("Are you sure you want to reset any progress and start over from the beginning of Round 1?")
                            }
                        }
                    }
                    if currentRound == 5 {
                        Button("Restart Process") {
                            startOver()
                        }
                        .padding(14)
                        .background(Color("ChuPrimary"))
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                    }
                    
                    StartAppBanner()
                        .frame(height: 50)
                        .background(Color(UIColor.secondarySystemBackground))
                    
                }
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
            content.body = "Round \(currentRound) is done, return to Tailwind to move on to Round \(currentRound + 1)!"
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
        timeRemaining = 1_800
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startOver() {
        currentRound = 1
        currentStep = 1
        currentStepperStep = 0
        timerFirstStarted = false
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

//Claude-generated property wrapper to let storedEndTime be compatible with iOS versions earlier than 18.0
@propertyWrapper
struct CompatibleAppStorage<Value> {
    private let key: String
    private let defaultValue: Value?
    
    var wrappedValue: Value? {
        get {
            UserDefaults.standard.object(forKey: key) as? Value
        }
        nonmutating set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    
    init(_ key: String, defaultValue: Value? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
            GuideView()
        .previewLayout(.sizeThatFits)
    }
}
