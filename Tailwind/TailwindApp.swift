//
//  TailwindApp.swift
//  Tailwind
//
//  Created by Daniel Marsh on 12/22/24.
//

import SwiftUI
import StartApp
import GoogleMobileAds

@main
struct TailwindApp: App {
    
    init() {
//        if let sdkInstance = STAStartAppSDK.sharedInstance() {
//            sdkInstance.appID = "201645580"
//            print("Start.io SDK initialized successfully")
//        } else {
//            print("Failed to initialize Start.io SDK")
//        }
        MobileAds.shared.start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}




