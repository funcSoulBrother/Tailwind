//
//  BuddyTasks.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/26/25.
//

import SwiftUI

final class BuddyTasks: ObservableObject {

    @Published var round1Tasks = [
        BuddyTask(name: "Feed your buddy a berry (three if you want to gain more Hearts)", isCompleted: false),
        BuddyTask(name: "Play with your buddy", isCompleted: false),
        BuddyTask(name: "Take a snapshot", isCompleted: false),
        BuddyTask(name: "Battle a team leader", isCompleted: false)
    ]

    @Published var round2Or4Tasks = [
        BuddyTask(name: "Feed your buddy one berry", isCompleted: false),
        BuddyTask(name: "Play with your buddy", isCompleted: false),
        BuddyTask(name: "Take a snapshot", isCompleted: false),
        BuddyTask(name: "Battle a team leader", isCompleted: false)
    ]

    @Published var round3Tasks = [
        BuddyTask(name: "Feed your buddy one berry (two if you fed your buddy three berries in Round 1 and you want another Heart)", isCompleted: false),
        BuddyTask(name: "Play with your buddy", isCompleted: false),
        BuddyTask(name: "Take a snapshot", isCompleted: false),
        BuddyTask(name: "Battle a team leader", isCompleted: false)
    ]

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
