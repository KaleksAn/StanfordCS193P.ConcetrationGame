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
    
    init(numberOfPairsCards: Int) {
        for _ in 1...numberOfPairsCards {
            let card = Card()
            cards += [card, card]
            
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
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
    
    func reset() {
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        indexOfOneAndOnlyFaceUpCard = nil
    }
    
    
}
