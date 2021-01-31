//
//  GoofyMemoryGame.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 30/12/2020.
//

import UIKit

typealias StringMemoryGame = MemoryGame<String>

class GoofyMemoryGame: ObservableObject {

    var theme: Theme
    @Published var model: StringMemoryGame

    init(theme: Theme) {
        self.theme = theme
        let content = theme.content
        model = MemoryGame(pairCount: content.count) { (index) -> String in
            return content[index]
        }
    }

    var cards: [StringMemoryGame.Card] {
        model.cards
    }

    func choose(card: StringMemoryGame.Card) {
        model.choose(card: card)
    }
}
