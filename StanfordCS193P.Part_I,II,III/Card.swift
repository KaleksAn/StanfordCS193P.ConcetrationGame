//
//  Card.swift
//  StanfordCS193P.Part_I,II,III
//
//  Created by Aleksandr Kan on 27.11.2021.
//

import Foundation


struct Card {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierfactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierfactory += 1
        return identifierfactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    
}

extension Card: Hashable {
    static func ==(lhs: Card, rhs: Card) -> Bool { return lhs.identifier == rhs.identifier }
}
