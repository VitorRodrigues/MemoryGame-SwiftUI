//
//  Theme.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 31/01/2021.
//

import UIKit

protocol Theme {
    var content: [String] { get }
    var cardColor: UIColor { get }
    var name: String { get }
}

class ThemeFactory {

    enum ThemeOption: CaseIterable {
        case none
        case halloween
        case heaven
        case cold
    }
    
    static func randomBuild() -> Theme {
        let randomFactor = Int.random(in: 0..<ThemeOption.allCases.count)
        let option = ThemeOption.allCases[randomFactor]
        return build(theme: option)
    }

    static func build(theme: ThemeOption) -> Theme {
        switch theme {
        case .halloween: return HalloweenTheme()
        case .heaven: return HeavenTheme()
        case .cold: return ColdTheme()
        default: return DefaultTheme()
        }
    }
}

struct DefaultTheme: Theme {
    var content: [String] = ["A", "B", "C", "D"]
    var cardColor: UIColor = .orange
    var name: String = "Halloween"
}

struct HalloweenTheme: Theme {
    var content: [String] = ["👻", "🎃", "🕷", "🧙‍♀️"]
    var cardColor: UIColor = .orange
    var name: String = "Halloween"
}

struct HeavenTheme: Theme {
    var content: [String] = ["👼", "🌞", "🌈", "✨"]
    var cardColor: UIColor = .cyan
    var name: String = "Heaven"
}

struct ColdTheme: Theme {
    var content: [String] = ["🧊", "🥶", "⛄️", "⛷"]
    var cardColor: UIColor = .blue
    var name: String = "Cold"
}
