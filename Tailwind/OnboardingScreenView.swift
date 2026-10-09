//
//  OnboardingScreenView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 2/15/25.
//

import SwiftUI

struct OnboardingScreen: View {
    @Binding var willOnboardingScreenShow: Bool
    
    var body: some View {
        ZStack {
            Color("EasyBG")
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .center) {
                    Text("Welcome to Tailwind!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("ChuQuaternary"))
                        .padding()
                }
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "map.fill")
                            .font(.title)
                            .foregroundColor(Color("ChuPrimary"))
                        Text("To dive right in, tap the \"The Guide\" button or tap the tab at the bottom of the screen. ")
                            .font(.title3)
                            .fontWeight(.light)
                    }
                    .padding()
                    HStack{
                        Image(systemName: "questionmark.circle.fill")
                            .font(.title)
                            .foregroundColor(Color("ChuPrimary"))
                        Text("You’ll probably be fine without it, but if you’re having trouble using the guide you should read through the \"How to Use\" section. It's a quick read.")
                            .font(.title3)
                            .fontWeight(.light)
                    }
                    .padding()
                    HStack{
                        if #available (iOS 17, *) {
                            Image(systemName: "brain.fill")
                                .font(.title)
                                .foregroundColor(Color("ChuPrimary"))
                        } else {
                            Image(systemName: "lightbulb.fill")
                                .font(.title)
                                .foregroundStyle(Color("ChuPrimary"))
                        }
                        Text("For all the gritty details go to the \"Mechanics\" section. This is where you’ll find a more detailed explanation of excitement and its mechanics. There are also some tips and tricks included that explain ways to make your buddy excited quicker and easier. Level up your excitement game!")
                            .font(.title3)
                            .fontWeight(.light)
                    }
                    .padding()
                }
                VStack(alignment: .center){
                    Button(action: { willOnboardingScreenShow.toggle()}) {
                        Text("Dismiss")
                            .padding()
                            .background(Color("ChuSecondary"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingScreen(willOnboardingScreenShow: .constant(true))
}
