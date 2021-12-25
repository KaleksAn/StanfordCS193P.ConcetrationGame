//
//  Concetration.swift
//  StanfordCS193P.Part_I,II,III
//
//  Created by Aleksandr Kan on 27.11.2021.
//

import Foundation

struct Concetration {
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    private var seenCards: Set<Int> = []
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsCards: Int) {
        assert(numberOfPairsCards > 0, "Concentration.init(\(numberOfPairsCards)): you must have at least one pair of card")
        for _ in 1...numberOfPairsCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
     mutating func chooseCard(at index: Int) {
        flipCount += HitPoints.oneHit
         assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): choosen index not in the cards")
         
         if !cards[index].isMatched {
             if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                 if cards[matchIndex] == cards[index] {
                     score += HitPoints.twoHit
                     cards[matchIndex].isMatched = true
                     cards[index].isMatched = true
                 } else {
                     checkSeenCards(forIndex: index, andMatch: matchIndex)
                     addSeenCards(forIndex: index, andMatch: matchIndex)
                 }
                 cards[index].isFaceUp = true
             } else {
                 indexOfOneAndOnlyFaceUpCard = index
             }
         }
    }
    
    private mutating func checkSeenCards(forIndex index: Int, andMatch matchIndex: Int) {
        if seenCards.contains(index) { score -= HitPoints.oneHit }
        if seenCards.contains(matchIndex) { score -= HitPoints.oneHit }
    }
    
    private mutating func addSeenCards(forIndex index: Int, andMatch matchIndex: Int) {
        seenCards.insert(index)
        seenCards.insert(matchIndex)
    }
    
    mutating func resetGame() {
        
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        
        flipCount = 0
        score = 0
        seenCards.removeAll()
        cards.shuffle()
    }
    
    
}

fileprivate struct HitPoints {
    static let oneHit = 1
    static let twoHit = 2
}
