//
//  ViewController.swift
//  StanfordCS193P.Part_I,II,III
//
//  Created by Aleksandr Kan on 24.11.2021.
//

import UIKit

class ViewController: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    var game: Concetration!
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🎃", "👻", "🦇", "😈", "🍭", "🙀", "😱", "🍎", "🧛‍♂️"]
    var emoji = [Int: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        game = Concetration(numberOfPairsCards: (cardButtons.count + 1) / 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //corner radius
        cornerRadius()
        
    }
    
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Choose card was not in cerdButtons")
        }
       
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for:card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            }
        }
    }
    
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func cornerRadius() {
        for view in cardButtons {
            view.layer.cornerRadius = 11.0
        }
    }
    
}

