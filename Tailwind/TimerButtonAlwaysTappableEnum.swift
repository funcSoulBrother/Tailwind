//
//  TimerButtonAlwaysTappableEnum.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 9/28/26.
//

import Foundation

enum TimerButtonAlwaysTappable: String, CaseIterable, Identifiable {
    case yes
    case no
    
    var id: Self { self }
    
    var name: String {
        switch self {
        case .yes:
            return "Yes"
        case .no:
            return "No"
        }
    }
    
    var image: String {
        switch self {
        case .yes:
            return "lock.open"
        case .no:
            return "lock"
        }
    }
}
