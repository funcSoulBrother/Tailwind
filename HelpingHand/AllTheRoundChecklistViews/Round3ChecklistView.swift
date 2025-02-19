//
//  Round3ChecklistView.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 1/30/25.
//

import SwiftUI

struct Round3ChecklistView: View {
    struct Task: Identifiable {
        let id = UUID()
        let name: String
        var isCompleted: Bool
    }
    
    @State private var round3Tasks = [
        Task(name: "Feed your buddy one berry (or two berries for an extra Heart)", isCompleted: false),
        Task(name: "Play with your buddy", isCompleted: false),
        Task(name: "Take a snapshot", isCompleted: false),
        Task(name: "Battle a team leader", isCompleted: false)
    ]
    
    @State private var animateTask: UUID? = nil

    var body: some View {
        List {
            ForEach($round3Tasks) { $task in
                HStack {
                    Text(task.name)
                    Spacer()
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? .green : .gray)
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
        if round3Tasks.allSatisfy({ $0.isCompleted }) {
                   Text("🎉 Your buddy is excited! 🎉")
                       .font(.headline)
                       .foregroundColor(.green)
                       .padding()
               }
    }
}


#Preview {
    Round3ChecklistView()
}
