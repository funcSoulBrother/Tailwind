//
//  zzzFunWithChecklists.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 1/30/25.
//

import SwiftUI

struct zzzFunWithChecklists: View {
    struct Task: Identifiable {
        let id = UUID()
        let name: String
        var isCompleted: Bool
    }
    
    @State private var tasks = [
        Task(name: "Feed your buddy", isCompleted: false),
        Task(name: "Play with your buddy", isCompleted: false),
        Task(name: "Take a snapshot", isCompleted: false),
        Task(name: "Battle a team leader", isCompleted: false)
    ]
    
    @State private var animateTask: UUID? = nil // Tracks the task being animated

    var body: some View {
        List {
            ForEach($tasks) { $task in
                HStack {
                    Text(task.name)
                    Spacer()
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? .green : .gray)
                        .scaleEffect(animateTask == task.id ? 1.2 : 1.0) // Scale effect on animation
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
        .navigationTitle("Buddy Tasks")
        if tasks.allSatisfy({ $0.isCompleted }) {
                   Text("🎉 Your buddy is excited! 🎉")
                       .font(.headline)
                       .foregroundColor(.green)
                       .padding()
               }
    }
}

#Preview {
    zzzFunWithChecklists()
}
