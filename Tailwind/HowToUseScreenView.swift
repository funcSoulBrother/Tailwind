//
//  HelpScreenView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 2/5/25.
//

import SwiftUI

struct HowToUseScreenView: View {
    @Environment(\.dismiss) var dismiss
    
    struct Task: Identifiable {
        let id = UUID()
        let name: String
        var isCompleted: Bool
    }
    
    @State var exampleTasks = [
        Task(name: "Play with your buddy (example task)", isCompleted: false)
    ]
    
    @State private var animateTask: UUID? = nil
    
    var body: some View {
        ScrollView {
            Spacer()
            Text("How to Use Helping Hand")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Text("In Pokémon Go complete every task listed at the top of the screen. The tasks look like this:")
                .padding()
            ForEach($exampleTasks) { $task in
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
                .padding()
            }
            Text("Once a task is complete, go back to Helping Hand to check it off the list. After every task is checked off, the buttons for the timer will activate. Press Start and wait 30 minutes for the timer to go off. ")
                .padding()
            if exampleTasks.allSatisfy({ $0.isCompleted }) {
                Button("Start (Example Button)") {
                    print("This is an example button. Yay!!!!")
                }
                    .padding()
                    .background(Color("ChuQuaternary"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            } else {
                Button("Start (Example Button)") {
                    print("This is an example button. Wonderful.")
                }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .foregroundColor(.secondary)
                    .cornerRadius(10)
                    .padding()
            }
            
            Text("Once the timer goes off a button will appear that will take you to the next round. The whole process will take around 2 hours if you just go by the guide. Read the Gritty Details section to see how it can be done quicker. Have fun spoiling your buddy!")
                .padding()

            Button("Got it!") {
                dismiss()
            }
            .frame(width: 100)
            .padding()
            .background(Color("ChuSecondary"))
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    HowToUseScreenView()
}
