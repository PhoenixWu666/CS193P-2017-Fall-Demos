//
//  ViewController.swift
//  Concentration
//
//  Created by Phoenix Wu on H30/03/27.
//  Copyright © 平成30年 Phoenix Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // avoid the count of cardButtons is odd, but it not so good. perhaps it is also a homework
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiChoices = ["🎃", "👻", "🧛🏻‍♀️", "🦇", "😈", "💀", "🍭", "🤡"]
    
    var emojiDictionary = [Int : String]()
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    func emoji(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emojiDictionary[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9994830489, green: 0.6620230675, blue: 0.1431986988, alpha: 0) : #colorLiteral(red: 0.9994830489, green: 0.6620230675, blue: 0.1431986988, alpha: 1)
            }
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9994830489, green: 0.6620230675, blue: 0.1431986988, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}

