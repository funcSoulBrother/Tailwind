//
//  HomeView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 12/24/24.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("LastSelectedTab") var savedSelectedTab: Int = 0
    @State var gettingStartedScreenShowing = false
    @State var boringDetailsScreenShowing = false
    
    var body: some View {
        
        ZStack {
            Color("EasyBG")
                .ignoresSafeArea()
            VStack (spacing: 50) {
                Image("tailwindLogo")
                    .resizable()
                    .scaledToFit()
                Text("Excite your buddy in Pokémon Go without poffins!")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 14)
                
                
                // How to implement HomeButton for future reference
                //            HomeButton(title: "The Guide") {
                //                savedSelectedTab = 1
                //            }
                
                HStack {
                    Button(action: {
                        gettingStartedScreenShowing = true
                    }) {
                        Text("How to Use")
                            .fontWeight(.bold)
                            .foregroundColor(Color("ChuSecondary"))
                            .padding()
                    }
                    
                    Divider()
                        .frame(height: 40)
                        .background(.secondary)
                    
                    Button(action: {
                        boringDetailsScreenShowing = true
                    }) {
                        Text("Mechanics")
                            .fontWeight(.bold)
                            .foregroundColor(Color("ChuSecondary"))
                            .padding()
                    }
                }
                
                Button(action: {
                    savedSelectedTab = 1
                }) {
                    Text("The Guide")
                        .frame(width: 275)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color("ChuSecondary"))
                        .foregroundColor(Color("EasyBG"))
                        .cornerRadius(10)
                }
                
            }
            .sheet(isPresented: $gettingStartedScreenShowing) {
                HowToUseScreenView()
            }
            .sheet(isPresented: $boringDetailsScreenShowing) {
                GrittyDetailsScreenView()
            }
        }
    }
}

// HomeButton struct no longer in use but saved for future reference
//struct HomeButton: View {
//    let title: String
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            Text(title)
//                .frame(width: 275)
//                .padding()
//                .background(Color("ChuPrimary"))
//                .foregroundColor(.black)
//                .cornerRadius(10)
//        }
//    }
//}


#Preview {
    HomeView()
}
