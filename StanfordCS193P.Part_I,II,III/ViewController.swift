//
//  ViewController.swift
//  StanfordCS193P.Part_I,II,III
//
//  Created by Aleksandr Kan on 24.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concetration(numberOfPairsCards: numberOfPairsCards)
    private var numberOfPairsCards: Int { return (cardButtons.count + 1) / 2 }
    private var emojiChoices = [String]()
    private var emoji = [Card: String]()
    private var colorCard = UIColor.systemOrange
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateViewFromModel()
        }
    }
    @IBOutlet private weak var newGameLabel: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    let collectionEmoji = [["🎃", "👻", "🦇", "😈", "🍭", "🙀", "😱", "🍎", "🧛‍♂️"],
                      ["🤖", "👽", "👩🏻‍🚀", "☄️", "⭐️", "🛰", "🛸", "🚀", "🔭"],
                      ["🇯🇵", "🇺🇿", "🇺🇸", "🇰🇷", "🇰🇿", "🇩🇪", "🇷🇺", "🇨🇦", "🇬🇧"],
                      ["🍏", "🍎", "🍌", "🍋", "🫐", "🍉", "🍓", "🥝", "🍒"],
                      ["🚗", "🏎", "🚲", "🚄", "🚂", "🚁", "🛳", "🚢", "🏍"],
                      ["⌚️", "💻", "📱", "📷", "🕹", "🎛", "🪛", "💡", "🔋"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indexEmoji = Int.random(in: 0..<collectionEmoji.count)
    }
    
    @IBAction private func touchNewGame(_ sender: UIButton) {
        game.resetGame()
        updateViewFromModel()
        indexEmoji = Int.random(in: 0..<collectionEmoji.count)
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Choose card was not in cerdButtons")
        }
       
    }
    
    private func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for:card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 0) : colorCard
            }
        }
    }
    
    
   private  func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card] ?? "?"
    }
    
    
    private var indexEmoji = 0 {
        didSet {
            emoji = [Card: String]()
            emojiChoices = collectionEmoji[indexEmoji]
        }
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key : Any] = [.strokeWidth: 5.0, .strokeColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
        
    }
}

