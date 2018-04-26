//
//  ViewController.swift
//  Concentration
//
//  Created by Phoenix Wu on H30/03/27.
//  Copyright © 平成30年 Phoenix Wu. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    // avoid the count of cardButtons is odd, but it not so good. perhaps it is also a homework
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
//    private var emojiChoices = ["🎃", "👻", "🧛🏻‍♀️", "🦇", "😈", "💀", "🍭", "🤡"]
    
    private var emojiChoices = "🎃👻🧛🏻‍♀️🦇😈💀🍭🤡"
    
    private var emojiDictionary = [Card : String]()
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emojiDictionary = [:]
            updateViewFromModel()
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey : Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func emoji(for card: Card) -> String {
        if emojiDictionary[card] == nil, emojiChoices.count > 0 {
                let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
                emojiDictionary[card] = String(emojiChoices.remove(at: randomIndex))
        }
        
        return emojiDictionary[card] ?? "?"
    }
    
    func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9994830489, green: 0.6620230675, blue: 0.1431986988, alpha: 0) : #colorLiteral(red: 0.1158126187, green: 0.1600519192, blue: 0.9994830489, alpha: 1)
                }
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

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

