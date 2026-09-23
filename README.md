# Tailwind

Tailwind is a native iOS application that provides an interactive guide that helps Pokémon GO players achieve the "Excited" Buddy status without using a Poffin.

[![Download on the App Store](./Tailwind/Assets.xcassets/AppStoreBadge.svg)](https://apps.apple.com/us/app/tailwind-guide/id6743378214)

## Overview

As a Pokémon Go player I always found the hidden process of making your buddy excited without a Poffin to be excessively complicated. I noticed that there were plenty of Reddit guides and infographics but recognized that an interactive guide would make the process infinitely more achievable and accessible to the average player. I decided that Tailwind was the perfect way to fill this niche while being a perfect beginning project to get my feet wet in the world of Swift and the App Store! 

## Screenshots

<p align="center">
  <img src="Tailwind/Promotional Screenshots/READMEScreenshotHome.png" width="250">
  <img src="Tailwind/Promotional Screenshots/READMEScreenshotChecklist.png" width="250">
  <img src="Tailwind/Promotional Screenshots/READMEScreenshotTimer.png" width="250">
</p>

## Features

- Checklist of things to do in order to excite your buddy
- Timers to let you know exactly when to do them
- Get notified when the timer ends by alarm (more intrusive) or by notification (less intrusive)
- Optional halfway reminders to make the process even faster
- Detailed mechanics explanation for users who want to dive deeper

## Technologies

- **Swift/SwiftUI** — Application development and user interface
- **UserNotifications** — Local notifications for timer completion and halfway reminders
- **AlarmKit** — Displays timer information on the Dynamic Island and provides an alarm-style alert when the timer ends
- **AppStorage** — Persists user settings and their current position in the guide
- **Google Mobile Ads SDK** — Displays banner advertisements

## Architecture

Structured using MVVM principles, with responsibilities separated between SwiftUI views, application logic, and data/state management. As my first iOS project, the architecture evolved as I became more familiar with Swift and SwiftUI.

## Development Highlights

- Implemented timer persistence so countdown progress could be restored after the app was closed, using Apple's date and time APIs to reliably calculate elapsed time.
- Added an AlarmKit-powered alarm as an option after its introduction in iOS 26, providing a more appropriate and interactive way to alert users when timers completed.
- Integrated local notifications for timer completion and halfway reminders.
- Managed the App Store submission and review process, addressing Apple's review feedback and ultimately releasing the application successfully.
- Debugged and troubleshot real-world application issues throughout development.
- Switched from Start.io to Google AdMob after encountering issues with ad availability, integrating and configuring a new advertising SDK.

## Requirements

- iOS: 16.0 or later
- To build: Xcode 26 or later, on macOS Sequoia 15.6 or later

## Installation

1. Clone the repository.
2. Open `Helping Hand.xcworkspace` in Xcode.
3. Select a simulator or connected device.
4. Build and run the application.


