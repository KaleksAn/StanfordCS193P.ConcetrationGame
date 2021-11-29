//
//  Concetration.swift
//  StanfordCS193P.Part_I,II,III
//
//  Created by Aleksandr Kan on 27.11.2021.
//

import Foundation

class Concetration {
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?
    private(set) var flipCount = 0
    
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
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
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
    
    
}
