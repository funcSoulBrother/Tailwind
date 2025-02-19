//
//  OnboardingScreenView.swift
//  HelpingHand
//
//  Created by Daniel Marsh on 2/15/25.
//

import SwiftUI

struct OnboardingScreen: View {
    @Binding var willOnboardingScreenShow: Bool
    @State private var glow = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("Welcome to Helping Hand!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("Your one-stop guide to making your buddy excited in Pokémon Go!")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
            }
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "map.fill")
                        .font(.title)
                    Text("To dive right in, press the “The Guide” button or press the tab at the bottom of the screen. ")
                        .font(.title3)
                        .fontWeight(.light)
                }
                .padding()
                HStack{
                    Image(systemName: "questionmark.circle.fill")
                        .font(.title)
                    Text("You’ll probably be fine without it, but if you’re having trouble using the guide you should probably read through the “How to Use” section.")
                        .font(.title3)
                        .fontWeight(.light)
                }
                .padding()
                HStack{
                    Image(systemName: "brain.fill")
                        .font(.title)
                    Text("For all the gritty details press the aptly named “Gritty Details” button. This is where you’ll find a more detailed explanation of excitement and its mechanics. There are also some tips and tricks included that explain ways to make your buddy excited quicker and easier. Level up your excitement game!")
                        .font(.title3)
                        .fontWeight(.light)
                }
                .padding()
            }
            VStack(alignment: .center){
                Button("Cool, Let's Do This!") {
                    willOnboardingScreenShow.toggle()
                }
                .fontWeight(.semibold)
                .padding(14)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
                .shadow(color: Color.blue.opacity(0.8), radius: glow ? 20 : 5, x: 0, y: 0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                        glow.toggle()
                        
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    OnboardingScreen(willOnboardingScreenShow: .constant(true))
}
