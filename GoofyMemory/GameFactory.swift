//
//  GameFactory.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 30/12/2020.
//

import Foundation

class GameFactory {

    static func createMemoryGame() -> GoofyMemoryGame {
        GoofyMemoryGame(theme: ThemeFactory.randomBuild())
    }

    static func createMemoryGame(theme: ThemeFactory.ThemeOption) -> GoofyMemoryGame {
        GoofyMemoryGame(theme: ThemeFactory.build(theme: theme))
    }
}
