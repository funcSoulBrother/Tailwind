//
//  TaskModel.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/26/25.
//
import Foundation

struct BuddyTask: Identifiable {
    let id = UUID()
    let name: String
    var isCompleted: Bool
}
