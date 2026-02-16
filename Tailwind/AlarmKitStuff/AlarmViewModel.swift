//
//  AlarmViewModel.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/6/25.
//
import AlarmKit
import SwiftUI
import AppIntents

@available(iOS 26, *)
@Observable class AlarmViewModel {
    typealias AlarmConfiguration = AlarmManager.AlarmConfiguration<CookingData>
    typealias AlarmsMap = [UUID: (Alarm, LocalizedStringResource)]
    private let cooldownAlarmID = UUID(uuidString: "A1E6F9B7-4B2E-4A63-9D0F-8E91E0B1C001")!
    
    @MainActor var alarmsMap = AlarmsMap()
    @ObservationIgnored let alarmManager = AlarmManager.shared
    
    @MainActor var hasUpcomingAlerts: Bool {
        !alarmsMap.isEmpty
    }
    
    init() {
        observeAlarms()
    }
    
    func fetchAlarms() {
        do {
            let remoteAlarms = try alarmManager.alarms
            updateAlarmState(with: remoteAlarms)
        } catch {
            print("Error fetching alarms: \(error)")
        }
    }
    
    // Schedules an alarm with a custom button to launch the app.
    ///The one to use
    func scheduleCooldownAlarm(currentRound: Int, timeRemaining: Int) {
        let id = cooldownAlarmID
        let alertContent = AlarmPresentation.Alert(
            title: "Round \(currentRound) Cooldown Over",
            stopButton: .stopButton,
            secondaryButton: AlarmButton(
                text: "Open Tailwind",
                textColor: .black,
                systemImageName: "map"  // Your custom SF Symbol
            ),
            secondaryButtonBehavior: .custom
        )
        
        let attributes = AlarmAttributes<CookingData>(presentation: AlarmPresentation(alert: alertContent),
                                                      tintColor: Color("ChuTertiary"))
        
        let alarmConfiguration = AlarmConfiguration(countdownDuration: .init(preAlert: TimeInterval(timeRemaining) - 1, postAlert: nil),
                                                    schedule: .justACuteLilAlarm,
                                                    attributes: attributes,
                                                    stopIntent: StopIntent(alarmID: id.uuidString),
                                                    secondaryIntent: OpenAlarmAppIntent(alarmID: id.uuidString))
        
        scheduleAlarm(id: id, label: "Cooldown Period", alarmConfiguration: alarmConfiguration)
    }
    
    func scheduleAlarm(id: UUID, label: LocalizedStringResource, alarmConfiguration: AlarmConfiguration) {
        Task {
            do {
//                don't want authorization message to trigger prematurely
                let alarm = try await alarmManager.schedule(id: id, configuration: alarmConfiguration)
                await MainActor.run {
                    alarmsMap[id] = (alarm, label)
                }
            } catch {
                print("Error encountered when scheduling alarm: \(error)")
            }
        }
    }
    
    func unscheduleAlarm(with alarmID: UUID) {
        try? alarmManager.cancel(id: alarmID)
        Task { @MainActor in
            alarmsMap[alarmID] = nil
        }
    }
    
    //ChatGPT function to unschedule cooldown alarm
    func cancelCooldownAlarm() {
        unscheduleAlarm(with: cooldownAlarmID)
    }
    
    private func alarmPresentation(with userInput: AlarmForm) -> AlarmPresentation {
        let secondaryButtonBehavior = userInput.secondaryButtonBehavior
        let secondaryButton: AlarmButton? = switch secondaryButtonBehavior {
            case .countdown: .repeatButton
            case .custom: .openAppButton
            default: nil
        }
        
        let alertContent = AlarmPresentation.Alert(title: userInput.localizedLabel,
                                                   stopButton: .stopButton,
                                                   secondaryButton: secondaryButton,
                                                   secondaryButtonBehavior: secondaryButtonBehavior)

        guard userInput.countdownDuration != nil else {
            // An alarm without a countdown only specifies an alert state.
            return AlarmPresentation(alert: alertContent)
        }
        
        // With countdown enabled, a presentation appears for both a countdown and paused state.
        let countdownContent = AlarmPresentation.Countdown(title: userInput.localizedLabel,
                                                           pauseButton: .pauseButton)
        
        let pausedContent = AlarmPresentation.Paused(title: "Paused",
                                                     resumeButton: .resumeButton)
        
        return AlarmPresentation(alert: alertContent, countdown: countdownContent, paused: pausedContent)
    }
    
    private func secondaryIntent(alarmID: UUID, userInput: AlarmForm) -> (any LiveActivityIntent)? {
        guard let behavior = userInput.secondaryButtonBehavior else { return nil }
        
        switch behavior {
        case .countdown:
            return RepeatIntent(alarmID: alarmID.uuidString)
        case .custom:
            return OpenAlarmAppIntent(alarmID: alarmID.uuidString)
        @unknown default:
            return nil
        }
    }
    
    private func observeAlarms() {
        Task {
            for await incomingAlarms in alarmManager.alarmUpdates {
                updateAlarmState(with: incomingAlarms)
            }
        }
    }
    
    private func updateAlarmState(with remoteAlarms: [Alarm]) {
        Task { @MainActor in
            
            // Update existing alarm states.
            remoteAlarms.forEach { updated in
                alarmsMap[updated.id, default: (updated, "Alarm (Old Session)")].0 = updated
            }
            
            let knownAlarmIDs = Set(alarmsMap.keys)
            let incomingAlarmIDs = Set(remoteAlarms.map(\.id))
            
            // Clean-up removed alarms.
            let removedAlarmIDs = Set(knownAlarmIDs.subtracting(incomingAlarmIDs))
            removedAlarmIDs.forEach {
                alarmsMap[$0] = nil
            }
        }
    }
    //Alarm Authorization code
    func requestAlarmAuthorization() async -> Bool {
        print("requestAlarmAuthorization called, current state: \(alarmManager.authorizationState)")
        
        switch alarmManager.authorizationState {
        case .notDetermined:
            print("State is notDetermined, requesting authorization...")
            do {
                let state = try await alarmManager.requestAuthorization()
                print("Authorization result: \(state)")
                return state == .authorized
            } catch {
                print("Error occurred while requesting authorization: \(error)")
                return false
            }
        case .denied:
            print("Authorization denied")
            return false
        case .authorized:
            print("Already authorized")
            return true
        @unknown default:
            print("Unknown authorization state")
            return false
        }
    }
}

@available(iOS 26, *)
extension AlarmButton {
    static var openAppButton: Self {
        AlarmButton(text: "Open Tailwind", textColor: .black, systemImageName: "swift")
    }
    
    static var pauseButton: Self {
        AlarmButton(text: "Pause", textColor: .black, systemImageName: "pause.fill")
    }
    
    static var resumeButton: Self {
        AlarmButton(text: "Start", textColor: .black, systemImageName: "play.fill")
    }
    
    static var repeatButton: Self {
        AlarmButton(text: "Repeat", textColor: .black, systemImageName: "repeat.circle")
    }
    
    static var stopButton: Self {
        AlarmButton(text: "Done", textColor: .white, systemImageName: "stop.circle")
    }
}

@available(iOS 26, *)
extension Alarm {
    var alertingTime: Date? {
        guard let schedule else { return nil }
        
        switch schedule {
        case .fixed(let date):
            return date
        case .relative(let relative):
            var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
            components.hour = relative.time.hour
            components.minute = relative.time.minute
            return Calendar.current.date(from: components)
        @unknown default:
            return nil
        }
    }
}

//Claude suggested fix (mainly "fixed" instead of "relative")
@available(iOS 26, *)
extension Alarm.Schedule {
    static var justACuteLilAlarm: Self {
        let targetDate = Date.now.addingTimeInterval(1)
        return .fixed(targetDate)
    }
    
    static var thirtyMinsFromNow: Self {
        let targetDate = Date.now.addingTimeInterval(30 * 60)
        return .fixed(targetDate)
    }
}

extension TimeInterval {
    func customFormatted() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: self) ?? self.formatted()
    }
}

extension Locale {
    var orderedWeekdays: [Locale.Weekday] {
        let days: [Locale.Weekday] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        if let firstDayIdx = days.firstIndex(of: firstDayOfWeek), firstDayIdx != 0 {
            return Array(days[firstDayIdx...] + days[0..<firstDayIdx])
        }
        return days
    }
}
