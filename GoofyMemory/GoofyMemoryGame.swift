//
//  GoofyMemoryGame.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 30/12/2020.
//

import Foundation

class GoofyMemoryGame: ObservableObject{
    
    @Published var model: MemoryGame = GoofyMemoryGame.createMemoryGame()

    private static func createMemoryGame() -> MemoryGame {
        let content = ["A", "B", "C"]
        return MemoryGame(pairCount: content.count) { (index) -> String in
            return content[index]
        }
    }

    var cards: [MemoryGame.Card] {
        model.cards
    }

    func choose(card: MemoryGame.Card) {
        model.choose(card: card)
    }
}
