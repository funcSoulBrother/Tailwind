//
//  CountDownLiveActivity.swift
//  CountDown
//
//  Created by Daniel Marsh on 11/30/25.
//

import WidgetKit
import SwiftUI
import AlarmKit

struct CountDownLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AlarmAttributes<CountDownAttribute>.self) { context in
            // Lock Screen view
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    switch context.state.mode {
                    case .countdown(let countdown):
                        Text(context.attributes.presentation.countdown?.title ?? "")
                            .font(.title3)
                        Text(countdown.fireDate, style: .timer)
                            .font(.title2)
                        
                    case .paused(let paused):
                        Text(context.attributes.presentation.paused?.title ?? "")
                            .font(.title3)
                        let formatter = Self.makeFormatter()
                        Text(formatter.string(from: paused.totalCountdownDuration - paused.previouslyElapsedDuration) ?? "0:00")
                            .font(.title2)
                        
                    case .alert(_):
                        Text(context.attributes.presentation.alert.title)
                            .font(.title3)
                        Text("0:00")
                            .font(.title2)
                        
                    @unknown default:
                        fatalError()
                    }
                }
                .lineLimit(1)
                
                Spacer(minLength: 0)
                
                Button("Cancel") { }
                    .tint(.orange)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
            }
            .padding(15)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("Minimal Content")
            }
            .keylineTint(Color.red)
        }
    }
    
    static func makeFormatter() -> DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }
}


