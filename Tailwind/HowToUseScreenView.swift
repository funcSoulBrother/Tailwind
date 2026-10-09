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
        Task(name: "Play with your buddy (example)", isCompleted: false)
    ]
    
    @State private var animateTask: UUID? = nil
    
    var body: some View {
        ZStack {
            Color("EasyBG")
                .ignoresSafeArea()
            ScrollView {
                Spacer()
                Text("How to Use Tailwind")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                Spacer()
                Text("Exciting your buddy in Pokémon Go consists of 5 rounds.")
                    .padding(.top, 20)
                    .padding(.horizontal, 19)
                Text("First you need to complete a set of tasks with your buddy. The tasks are listed at the top of the screen. They look like this:")
                    .padding(20)
                ForEach($exampleTasks) { $task in
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
                    .padding()
                    .padding(.trailing, 20)
                }
                Text("Once a task is completed in Pokémon Go, return to Tailwind and check it off the list by tapping the box next to it. After every task is checked off, the button that will start the cooldown timer will activate. Tap it as soon as you can. (Alternatively, if you don't want to have to check every box to start the timer every time, go to Settings and set Timer Button Always Tappable to Yes)")
                    .padding(20)
                if exampleTasks.allSatisfy({ $0.isCompleted }) {
                    Button("Start Cooldown (Example)") {
                        print("This is an example button. Yay!!!!")
                    }
                    .padding()
                    .background(Color("ChuQuaternary"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                } else {
                    Button("Start Cooldown (Example)") {
                        print("This is an example button. Wonderful.")
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .foregroundColor(.secondary)
                    .cornerRadius(10)
                    .padding()
                }
                
                Text("Tapping the button will start the 30-minute cooldown timer. You have to wait this amount of time or else the next round's tasks won't count. Once the timer goes off a button will appear that will take you to the next round.")
                    .padding(20)
                Text("The whole process will take a little more than 2 hours if you just go by this guide. Read the \"Mechanics\" section to see how it can be done in 1.5 hours. Have fun spoiling your buddy!")
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Go Back")
                        .frame(width: 100)
                        .padding()
                        .background(Color("ChuSecondary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 40)
                }
            }
        }
    }
}

#Preview {
    HowToUseScreenView()
}
