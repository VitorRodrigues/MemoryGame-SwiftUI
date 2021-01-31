//
//  MemoryGame.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 30/12/2020.
//

import Foundation
import Combine

struct MemoryGame<CardContent> where CardContent: Equatable {

    let matchScorePoint = 10
    let unmatchScorePoint = -1

    var cards: [Card]
    var score = 0

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

    init(pairCount: Int, content: (Int) -> CardContent) {
        cards = (0..<pairCount).flatMap { index in
            [Card(content: content(index), id: index*2),
            Card(content: content(index), id: index*2+1)]
        }
        cards.shuffle()
    }

    // MARK: - Intents

    public mutating func choose(card: Card) {
        guard let cardIndex = cards.firstIndex(matching: card), !cards[cardIndex].isFaceUp, !cards[cardIndex].isMatched else { return }

        if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
            if cards[potentialMatchIndex].content == cards[cardIndex].content {
                cards[potentialMatchIndex].isMatched = true
                cards[cardIndex].isMatched = true
                score += matchScorePoint
            } else {
                score += unmatchScorePoint
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
        var content: CardContent
        var id: Int
    }
}
