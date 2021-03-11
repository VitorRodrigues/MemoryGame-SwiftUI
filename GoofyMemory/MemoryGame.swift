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

    private(set) var cards: [Card]
    private(set) var score = 0

    private var indexOfOneAndOnlyFaceUpCard: Int? {
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
                score += Int(Double(matchScorePoint) * cards[potentialMatchIndex].bonusRemaining * cards[cardIndex].bonusRemaining)
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
        var isFaceUp = false {
            didSet {
                if isFaceUp { 
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        
        // MARK: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let date = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(date)
            }
            
            return pastFaceUpTime   
        }
        
        // Last time a card has faceup and is still faced up
        var lastFaceUpDate: Date?
        // Accumulated time this card was face up in the past
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // % of remaining bonus time
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // card is matched during the bonus time
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // if is consuming bonus because the card is faceup and it did not match yet
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // Called when transitioned to FaceUp state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}


