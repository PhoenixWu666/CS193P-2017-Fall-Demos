//
//  Card.swift
//  Concentration
//
//  Created by Phoenix Wu on H30/03/28.
//  Copyright © 平成30年 Phoenix Wu. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    
    var isMatched = false
    
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
