//
//  ViewController.swift
//  Concentration
//
//  Created by Jack Gernert on 8/29/18.
//  Copyright © 2018 Jack Gernert. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game: Concentration =
        Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count+1) / 2
        }
    
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
        }

    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for : card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 0) : #colorLiteral(red: 0.0839106515, green: 0.44887501, blue: 1, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻","👽","🎃","👺","👹","💀","🤖","🍭","🍫"]
    
    var emoji = [Int:String]()
    
    func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
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
