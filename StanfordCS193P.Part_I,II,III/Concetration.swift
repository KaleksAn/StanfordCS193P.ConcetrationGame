//
//  Concetration.swift
//  StanfordCS193P.Part_I,II,III
//
//  Created by Aleksandr Kan on 27.11.2021.
//

import Foundation

class Concetration {
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    private var seenCards: Set<Int> = []
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsCards: Int) {
        for _ in 1...numberOfPairsCards {
            let card = Card()
            cards += [card, card]
            
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    score += 2
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                } else {
                    checkSeenCards(forIndex: index, andMatch: matchIndex)
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            
            }
            
        }
    }
    
    func checkSeenCards(forIndex index: Int, andMatch matchIndex: Int) {
        if seenCards.contains(index) { score -= 1 }
        if seenCards.contains(matchIndex) { score -= 1 }
    }
    
}
