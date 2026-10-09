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
    @ObservedObject var buddyTasks: BuddyTasks
    @ObservedObject var timerState: TimerState
    @State var isBlinking = false
    @State var showRound1Alert = false
    @State var showStartOverAlert = false
    @State var showResetTimerAlert = false
    @State var helpScreenShowing = false
    @State var notificationPermissionScreenShowing = false
    @State var notificationWarningTextShowing = false
    @State var alarmPermissionScreenShowing = false
    @State var alarmWarningTextShowing = false
    @State var notificationViewModel = NotificationViewModel()
    @State private var activeWarning: WarningType = .none
    @AppStorage("CurrentRound") var currentRound = 1
    @AppStorage("CurrentStep") var currentStep = 1
    @AppStorage("CurrentStepperStep") var currentStepperStep = 0
    @AppStorage("CooldownEndOption") var selectedOption: CooldownEndOption = .alarm
    @AppStorage("TimerButtonAlwaysTappableOption") var selectedTimerButtonTappableOption: TimerButtonAlwaysTappable = .no
    let notificationWarningText = "Notification permission has been denied so you will not see a notification when the cooldown period is over. Tap this message to turn on notifications in your phone's settings."
    let alarmWarningText = "Alarm permission has been denied so an alarm won't go off when the cooldown period is over. Tap this message to turn on alarms in your phone's settings."
    @CompatibleAppStorage("TimerEndTime") var storedEndTime: Date?
    // Test ad unit ID
    private let testAdUnitID = "ca-app-pub-3940256099942544/2934735716"
    // Real ad unit ID
    private let guideAdUnitID = "ca-app-pub-1269877083649460/4228051161"
    
    @State private var animateTask: UUID? = nil
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
                                Text("Complete the following tasks with your buddy in Pokémon Go. After each task is completed and checked off, the Cooldown button will be enabled.")
                                    .fontWeight(.semibold)
                            }
                            if currentRound == 1 {
                                ForEach($buddyTasks.round1Tasks) { $task in
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
                                ForEach($buddyTasks.round2Or4Tasks) { $task in
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
                                ForEach($buddyTasks.round3Tasks) { $task in
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
                        
                        if buddyTasks.round1Tasks.allSatisfy({ $0.isCompleted }) || buddyTasks.round2Or4Tasks.allSatisfy({ $0.isCompleted}) || buddyTasks.round3Tasks.allSatisfy({ $0.isCompleted}) || selectedTimerButtonTappableOption == .yes {
                            if #available (iOS 17.0, *) {
                                if selectedTimerButtonTappableOption == .yes { //non-blinking button for iOS 17 and later
                                    Button("Start Cooldown Timer") {
                                        currentStep = 2
                                    }
                                    .fontWeight(.semibold)
                                    .padding(14)
                                    .background(Color("ChuSecondary"))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                } else { //blinking button
                                    Button("Start Cooldown Timer") {
                                        currentStep = 2
                                    }
                                    .fontWeight(.semibold)
                                    .padding(14)
                                    .background(isBlinking ? Color(Color("ChuQuaternary")) : Color("ChuSecondary"))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .onAppear {
                                        startBlinking()
                                    }
                                }
                            } else { //non-blinking button for earlier than iOS 17
                                Button("Start Cooldown Timer") {
                                    currentStep = 2
                                    print("Step \(currentStep)")
                                }
                                .fontWeight(.semibold)
                                .padding(14)
                                .background(Color("ChuSecondary"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                        } else {
                            if currentRound != 5 {
                                Button("Start Cooldown Timer") {
                                    print("This button is disabled.")
                                }
                                .fontWeight(.semibold)
                                .padding(14)
                                .background(Color(UIColor.secondarySystemBackground))
                                .foregroundColor(.secondary)
                                .cornerRadius(10)
                            }
                        }
                    } else { //Step 1 zone over, Step 2 zone begins (Cooldown)
                        VStack {
                            Text("Wait 30 minutes for the cooldown period before you start Round \(currentRound + 1).")
                                .fontWeight(.semibold)
                                .padding()
                            if currentRound <= 4 {
                                if #available (iOS 17.0, *) {
                                    Text(timerState.formatTime(timerState.timeRemaining))
                                        .contentTransition(.numericText())
                                        .animation(.linear, value: timerState.timeRemaining)
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                        .padding()
                                } else { //figured out that the animation doesn't work so great on anything earlier than iOS 17
                                    Text(timerState.formatTime(timerState.timeRemaining))
                                        .contentTransition(.numericText())
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                        .padding()
                                }
                                
                                ZStack { //just to keep everything neatly in place when next round button appears
                                    if timerState.timeRemaining != 0 {
                                        HStack {
                                            Spacer().frame(width: 80)
                                            if timerState.timerActive == false {
                                                VStack {
                                                    Button(action: {
                                                        if #available(iOS 26, *) {
                                                            timerState.startTimer26()
                                                        } else {
                                                            timerState.startTimerLegacy()
                                                        }
                                                    }) {
                                                        Image(systemName: "play.circle.fill")
                                                            .font(.system(size: 70))
                                                            .fontWeight(.bold)
                                                            .foregroundColor(Color("ChuSecondary"))
                                                            .padding()
                                                    }
                                                    Button(action: {
                                                        if #available(iOS 26, *) {
                                                            timerState.startTimer26()
                                                        } else {
                                                            timerState.startTimerLegacy()
                                                        }
                                                    }) {
                                                        Text("Start Timer")
                                                            .foregroundColor(Color("ChuSecondary"))
                                                    }
                                                }
                                            } else {
                                                VStack {
                                                    Button(action: {
                                                        if #available(iOS 26, *) {
                                                            timerState.pauseTimer26()
                                                        } else {
                                                            timerState.pauseTimerLegacy()
                                                        }
                                                    }) {
                                                        Image(systemName: "pause.circle.fill")
                                                            .foregroundColor(Color("ChuSecondary"))
                                                            .font(.system(size: 70))
                                                            .fontWeight(.bold)
                                                            .padding()
                                                    }
                                                    Button(action: {
                                                        if #available(iOS 26, *) {
                                                            timerState.pauseTimer26()
                                                        } else {
                                                            timerState.pauseTimerLegacy()
                                                        }
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
                                                                timerState.resetTimer()
                                                            }
                                                        } message: {
                                                            Text("Are you sure you want to reset the timer back to 30 minutes?")
                                                        }
                                                }
                                                Button(action: {
                                                    timerState.resetTimer()
                                                }) {
                                                    Text("Reset Timer")
                                                        .foregroundColor(Color("ChuTertiary"))
                                                        .font(.system(size: 15))
                                                }
                                            }
                                        }
                                        .sheet(isPresented: $notificationPermissionScreenShowing) {
                                            NotificationPermissionView(timerState: timerState)
                                                .presentationDetents([.height(500), .large])
                                                .presentationDragIndicator(.visible)
                                        }
                                        .sheet(isPresented: $alarmPermissionScreenShowing) {
                                            if #available(iOS 26, *) {
                                                AlarmPermissionView(timerState: timerState)
                                                    .presentationDetents([.medium, .large])
                                                    .presentationDragIndicator(.visible)
                                            }
                                        }
                                        .onAppear() {
                                            if selectedOption == .notification {
                                                checkNotificationPermission()
                                            } else {
                                                if #available(iOS 26, *) {
                                                    Task {
                                                        await checkAlarmPermissionOrScheduleAlarm()
                                                    }
                                                } else {
                                                    checkNotificationPermission()
                                                }
                                            }
                                        }
                                        .onChange(of: scenePhase) { phase in
                                            if phase == .active {
                                                if selectedOption == .notification {
                                                    checkNotificationPermission()
                                                    if timerState.timerActive == true && timerState.timeRemaining > 0 {
                                                        notificationViewModel.cancelNotificationAlert()
                                                        notificationViewModel.scheduleNotificationAlert(currentRound: currentRound, timeRemaining: timerState.timeRemaining)
                                                    }
                                                } else {
                                                    if #available(iOS 26, *) {
                                                        Task {
                                                            await checkAlarmPermissionOrScheduleAlarm()
                                                        }
                                                    } else {
                                                        checkNotificationPermission()
                                                        if timerState.timerActive == true && timerState.timeRemaining > 0 {
                                                            notificationViewModel.cancelNotificationAlert()
                                                            notificationViewModel.scheduleNotificationAlert(currentRound: currentRound, timeRemaining: timerState.timeRemaining)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        if let text = activeWarning.text {
                                            Button(text) {
                                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                                    UIApplication.shared.open(url)
                                                }
                                            }
                                            .font(.caption2)
                                            .background(.pink.opacity(0.0001))
                                            .offset(y: -77)
                                        }
                                    }
                                    if timerState.timeRemaining == 0 {
                                        if #available (iOS 17.0, *) {
                                            Button("Start Round \(currentRound + 1)") {
                                                currentRound += 1
                                                currentStep = 1
                                                currentStepperStep += 1
                                                timerState.timerFirstStarted = false
                                                timerState.resetTimer()
                                                buddyTasks.resetTasks()
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
                                                timerState.timerFirstStarted = false
                                                timerState.resetTimer()
                                                buddyTasks.resetTasks()
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
                                if !timerState.timerActive {
                                    if !timerState.timerFirstStarted {
                                        if #available(iOS 26, *) {
                                            timerState.startTimer26()
                                        } else {
                                            timerState.startTimerLegacy()
                                        }
                                        timerState.timerFirstStarted = true
                                    }
                                }
                            }
                        }
                        .onChange(of: scenePhase) { phase in
                            if phase == .inactive {
                                print("Inactive")
                            } else if phase == .active {
                                print("Active")
                                timerState.restoreTimer()
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
                    
                        AdBannerView(adUnitID: guideAdUnitID)
                                    .frame(height: 50)
                                    .background(Color(UIColor.secondarySystemBackground))
                    ///old Start.io code
//                    StartAppBanner()
//                        .frame(height: 50)
//                        .background(Color(UIColor.secondarySystemBackground))
                    
                }
            }
        }
    }
    
    func startOver() {
        currentRound = 1
        currentStep = 1
        currentStepperStep = 0
        timerState.timerFirstStarted = false
        timerState.resetTimer()
        buddyTasks.resetTasks()
    }
    
    private func startBlinking() {
        withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
            isBlinking.toggle()
        }
    }
    
    func checkNotificationPermission() {
        // Get the current notification settings
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                // User hasn't been asked yet - request permission
                print("Not determined - requesting permission")
                notificationPermissionScreenShowing = true
            } else if settings.authorizationStatus == .authorized {
                // Permission granted - schedule notifications
                activeWarning = .none
                print("Authorized - can schedule notifications")
            } else if settings.authorizationStatus == .denied {
                // Permission denied - show alert to guide user to settings
                activeWarning = .notification
                print("Denied - prompt user to enable in Settings")
            } else if settings.authorizationStatus == .provisional {
                // Provisional authorization (iOS 12+)
                print("Provisional authorization")
            } else if settings.authorizationStatus == .ephemeral {
                // Ephemeral authorization (App Clips)
                print("Ephemeral authorization")
            }
        }
    }
    
    @available(iOS 26, *)
    func checkAlarmPermissionOrScheduleAlarm() async -> Bool {
        let alarmViewModel = AlarmViewModel()
        print("requestAlarmAuthorization called, current state: \(alarmViewModel.alarmManager.authorizationState)")
        
        switch alarmViewModel.alarmManager.authorizationState {
        case .notDetermined:
            print("State is notDetermined, requesting authorization...")
            alarmPermissionScreenShowing = true
            return false
        case .denied:
            activeWarning = .alarm
            print("Authorization denied")
            return false
        case .authorized:
            activeWarning = .none
            alarmViewModel.scheduleCooldownAlarm(currentRound: currentRound, timeRemaining: self.timerState.timeRemaining)
            print("Already authorized")
            return true
        @unknown default:
            print("Unknown authorization state")
            return false
        }
    }
}


///old Start.io code
//struct StartAppBanner: UIViewRepresentable {
//    func makeUIView(context: Context) -> STABannerView {
//        print("🔧 StartAppBanner: makeUIView called")
//        // Create a default UIView to return if banner creation fails
//        let defaultView = STABannerView()
//        
//        // Try to create the banner with safe unwrapping
//        if let banner = STABannerView(size: STA_AutoAdSize,
//                                    origin: CGPoint(x: 0, y: 0),
//                                    withDelegate: context.coordinator) {
//            print("✅ StartAppBanner: Banner created successfully, calling loadAd()")
//            banner.loadAd()
//            return banner
//        } else {
//            print("❌ StartAppBanner: Failed to create STABannerView")
//            return defaultView
//        }
//    }
//    
//    func updateUIView(_ uiView: STABannerView, context: Context) {
//        // Updates if needed
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//    
//    class Coordinator: NSObject, STABannerDelegateProtocol {
//        func didDisplayBannerAd(_ banner: STABannerView) {
//            print("✅ StartAppBanner: Banner ad displayed")
//        }
//        
//        func failedLoadBannerAd(_ banner: STABannerView, withError error: Error) {
//            print("❌ StartAppBanner: Banner ad failed: \(error.localizedDescription)")
//        }
//    }
//}

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

//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//            GuideView()
//        .previewLayout(.sizeThatFits)
//    }
//}
