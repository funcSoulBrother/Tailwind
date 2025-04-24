//
//  GrittyDetailsScreenView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 2/11/25.
//

import SwiftUI

struct GrittyDetailsScreenView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color("EasyBG")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Excited Mechanics")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 40)
                    Text("Each time you interact with your buddy in Pokémon Go it becomes happier and happier. If you interact with your buddy enough it’ll be in an excited state. But the methods for making your buddy excited is not explicitly stated in game and the mechanics are somewhat confusing. This excited state can also be reached by giving your buddy a Poffin, but what if you’re all out of Poffins and you don’t want to shell out the cash to buy more? This guide is intended to be your one stop guide for the most efficient way to make your buddy excited in Pokémon Go without a Poffin.")
                        .padding(30)
                    Text("But why should I care about making my buddy excited?")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("There are two big perks to having an excited buddy: halved buddy candy walk distance and double daily Hearts. The first perk makes it so that you need to walk half the distance in order to get candies from your buddy. This is a great perk for anyone looking to farm candies (or mega energy or candies XL), especially during a time period or event when you plan on walking a lot. The second perk allows you to earn twice as many daily Hearts which is a must for anyone who wants to achieve Best Buddies as soon as possible. ")
                        .padding(30)
                    Text("Basic Mechanics")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Everything you do with your buddy that makes it gain Hearts will also make it gain Emotion Points. Emotion Points are the units you need to make your buddy excited. However, there are definitely differences in the way they can be earned. Emotion Points are tricky because, unlike Hearts, Pokémon Go doesn’t show you how many you’ve earned. There’s no way to know how many your buddy has earned until they’re excited. Another difference is the cooldown period. Your buddy can earn all of its Hearts as quickly as possible without having to wait (unless you count the 1 hour feeding cooldown period, but even that can be bypassed by switching buddies). Emotion Points, on the other hand, have 30-minute cooldown periods (except for Emotion Points earned by walking). Which means that, just as an example, after you play with your buddy, you’ll have to wait 30 minutes before you can earn another Emotion Point by playing with your buddy. That’s why this guide does everything in half hour rounds. Also note that Emotion Points decay in time, so it’s important that you start the next round as quickly as you can after the timer goes off.")
                        .padding(30)
                    Text("How long does the process take?")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding()
                    Text("A little more than 2 hours (four 30-minute rounds and a couple of minutes for doing everything in between rounds)")
                        .padding(30)
                    Text("That's too long, I'm a busy person. Can I do it faster?")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Yes! This guide assumes that you can only do the bare minimum; that is, things you can do from anywhere at any time without any other players. But if you can perform just 1 of the following extra actions any time during the process, it’ll take 30 minutes off of the total time:")
                        .padding(30)
                    Text("""
                            • Battle a Team GO Rocket member
                            • Battle in the GBL
                            • Battle a friend
                            • Battle in a gym
                            • Battle in a raid
                            • Battle in a Max Battle
                            • Walk 2km with your buddy
                            • Receive an item from your buddy
                            • Receive a souvenir from your buddy
                            • Visit a new place with your buddy
                            • Visit a place your buddy wants to visit
                            • Follow a route with your buddy
                            """)
                    .fontWeight(.light)
                    Text("Probably the easiest of these to do is battling a Team GO Rocket member. Try to time the process so that a Rocket balloon shows up at some point during the process and you’re good to go.")
                        .padding(30)
                    Text("Tips & Tricks")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Berries")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 30)
                    Text("1 berry each round is enough to get your buddy excited. However, if you want your buddy to earn Hearts at the same time as making it excited, read through the rest of this section. After making it full, your buddy has a 1 hour cooldown period for earning Hearts (which is different from the 30 minute cooldown period of Emotion Points). That means, in order to gain the most Hearts and Emotion Points while minimizing the amount of berries you need to use, you’ll want to feed your buddy the following during the process of making it excited:")
                        .padding(30)
                    Text("""
                            Round 1: 3 berries (takes your buddy’s belly from empty to full, earns first Heart)
                            Round 2: 1 berry
                            Round 3: 2 berries (after an hour your buddy is only partially full, 2 berries makes buddy full and earns second Heart)
                            Round 4: 1 berry
                            Round 5: 2 berries (earns third Heart)
                            """)
                    .fontWeight(.light)
                    .padding(.horizontal, 50)
                    Text("Don’t worry about memorizing this list, though, because the numbers are repeated in the guide for anyone who wants to gain Hearts along with Emotion Points!")
                        .padding(30)
                    Text("Battling")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding()
                    Text("Rapidfire battling basics: your buddy has to be in your battle team. Your buddy doesn’t have to actually participate in battle. It doesn’t matter if your buddy faints.")
                        .padding(.horizontal, 30)
                    Text("You can run from some types of battles and it’ll still count toward Emotion Points. However, some you need to complete in order for them to count. Here’s a detailed breakdown:")
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .padding(.top, 20)
                    Text("""
                            Team Leader Battles: you can run
                            Team GO Rocket Battles: you can run
                            GBL Battles: you have to complete the battle
                            Other PvP Battles: you have to complete the battle
                            Gym Battles: you have to finish a battle against 1 pokémon
                            Raids: you have to finish the raid
                            Max Battles: you have to complete the battle
                            """)
                    .fontWeight(.light)
                    .padding(.horizontal, 50)
                    Text("You may already know that in order to get battling Hearts your buddy has to be adventuring with you (or you had to have given your buddy 3 berries first). However, this isn’t the case with Emotion Points. You can give your buddy 1 berry each round and each battle will still count towards making it excited.")
                        .padding(30)
                    Text("Earlier I stated that each task that earns Emotion Points has a 30 minute cooldown period and this is the case with battles as well. However, different types of battles have their own cooldown periods. For example, battling a team leader 3 times in 30 minutes will only count once toward increasing your buddy’s Emotion Points, but battling a Team GO Rocket member, a team leader, and a gym within the same 30 minute period will count 3 times.")
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                    Text("That's it, that's all you need to know about making your buddy pokémon excited! Now go out there and reap the benefits of a really happy buddy!")
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                    
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Alright!")
                            .frame(width: 100)
                            .padding()
                            .background(Color("ChuSecondary"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Text("* Please note that I’ve tested all of these mechanics myself and I can attest that they’re all accurate at the time of writing. However, any of these rules can be changed by Niantic at any time whether it be on purpose or unintended glitch. I strive for this to be the definitive Pokémon Go excited guide, so if you notice any discrepancies between this guide and the in-game mechanics, please don’t hesitate to email me at cresylvioletapps@icloud.com")
                        .padding(30)
                }
                .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    GrittyDetailsScreenView()
}
