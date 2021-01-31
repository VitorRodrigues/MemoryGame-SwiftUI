//
//  MemoryGame.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 30/12/2020.
//

import Foundation
import Combine

struct MemoryGame {

    var cards: [Card]

    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }

    init(pairCount: Int, content: (Int) -> String) {
        cards = (0..<pairCount).flatMap { index in
            [Card(content: content(index), id: index*2),
            Card(content: content(index), id: index*2+1)]
        }
    }

    // MARK: - Intents

    public mutating func choose(card: Card) {
        guard let cardIndex = cards.firstIndex(matching: card), !cards[cardIndex].isFaceUp, !cards[cardIndex].isMatched else { return }

        if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
            if cards[potentialMatchIndex].content == cards[cardIndex].content {
                cards[potentialMatchIndex].isMatched = true
                cards[cardIndex].isMatched = true
            }
            cards[cardIndex].isFaceUp = true
        } else {
            indexOfOneAndOnlyFaceUpCard = cardIndex
        }
    }
}

extension MemoryGame {
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: String
        var id: Int
    }
}
