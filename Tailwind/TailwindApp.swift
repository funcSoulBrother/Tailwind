//
//  TailwindApp.swift
//  Tailwind
//
//  Created by Daniel Marsh on 12/22/24.
//

import SwiftUI
import StartApp

@main
struct TailwindApp: App {
    
    init() {
        if let sdkInstance = STAStartAppSDK.sharedInstance() {
            sdkInstance.appID = "201645580"
            sdkInstance.testAdsEnabled = true
            print("Start.io SDK initialized successfully")
        } else {
            print("Failed to initialize Start.io SDK")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}




