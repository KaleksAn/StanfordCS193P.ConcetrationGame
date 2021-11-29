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
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var newGameLabel: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices: [String]!
    var emoji: [Int: String]!
    var colorForCard: UIColor!
    var emojiAndColors : (emoji: [String], backgroundColor: UIColor, generalColor: UIColor)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emojiAndColors = themeFactory()
        game = Concetration(numberOfPairsCards: (cardButtons.count + 1) / 2)
        setEmoji(with: emojiAndColors.emoji)
        setLabel()
        setColor(forBackground: emojiAndColors.backgroundColor, andTheme: emojiAndColors.generalColor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cornerRadius()
    }
    
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        viewDidLoad()
        updateViewFromModel()
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Choose card was not in cerdButtons")
        }
       
    }
    
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for:card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 0) : colorForCard
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
    
    func themeFactory() -> (emoji: [String], backgroundColor: UIColor, generalColor: UIColor) {
        let collection = [["🎃", "👻", "🦇", "😈", "🍭", "🙀", "😱", "🍎", "🧛‍♂️"],
                          ["🤖", "👽", "👩🏻‍🚀", "☄️", "⭐️", "🛰", "🛸", "🚀", "🔭"],
                          ["🇯🇵", "🇺🇿", "🇺🇸", "🇰🇷", "🇰🇿", "🇩🇪", "🇷🇺", "🇨🇦", "🇬🇧"],
                          ["🍏", "🍎", "🍌", "🍋", "🫐", "🍉", "🍓", "🥝", "🍒"],
                          ["🚗", "🏎", "🚲", "🚄", "🚂", "🚁", "🛳", "🚢", "🏍"],
                          ["⌚️", "💻", "📱", "📷", "🕹", "🎛", "🪛", "💡", "🔋"]]
        
        var index : Int {
            get {
                let count = UInt32(collection.count)
                let randomNumber = arc4random_uniform(count)
                return Int(randomNumber)
            }
        }
        
        let backgroundColorsCollection = UIColor(displayP3Red: .random(in: 0.0...0.2), green: .random(in: 0.0...0.2), blue: .random(in: 0.0...0.3), alpha: 1.0)
        let generalColorsCollection =  UIColor(hue: .random(in: 0.0...1.0), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
        return (collection[index], backgroundColorsCollection, generalColorsCollection)
    }
    
    func setColor(forBackground backViewColor: UIColor, andTheme themeViewColor: UIColor) {
        cardButtons.forEach { button in button.backgroundColor = themeViewColor }
        colorForCard = themeViewColor
        newGameLabel.setTitleColor(themeViewColor, for: .normal)
        flipCountLabel.textColor = emojiAndColors.generalColor
        view.backgroundColor = backViewColor
    }
    
    func setLabel() {
        newGameLabel.setTitle("New GAME", for: .normal)
        newGameLabel.titleLabel?.font = .systemFont(ofSize: 40.0, weight: .medium)
    }
    
    func setEmoji(with collection: [String]) {
        emoji = [:]
        emojiChoices = collection
    }
    
    func cornerRadius() {
        for view in cardButtons {
            view.layer.cornerRadius = 11.0
        }
    }
    
    
}

