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
    @IBOutlet weak var newGameLabel: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices: [String]!
    var emoji: [Int: String]!
    var colorForCard: UIColor!
    var emojiAndColors : (emoji: [String], backgroundColor: UIColor, cardColor: UIColor)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emojiAndColors = emojiAndColorCollection()
        
        cardButtons.forEach { button in
            button.backgroundColor = emojiAndColors.cardColor
        }
        
        game = Concetration(numberOfPairsCards: (cardButtons.count + 1) / 2)
        emoji = [:]
        emojiChoices = emojiAndColors.emoji
        colorForCard = emojiAndColors.cardColor
        newGameLabel.setTitleColor(.orange, for: .normal)
        flipCountLabel.textColor = emojiAndColors.cardColor
        view.backgroundColor = emojiAndColors.backgroundColor
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
    
    func emojiAndColorCollection() -> (emoji: [String], backgroundColor: UIColor, cardColor: UIColor) {
        let collection = [["🎃", "👻", "🦇", "😈", "🍭", "🙀", "😱", "🍎", "🧛‍♂️"],
                          ["🤖", "👽", "👩🏻‍🚀", "☄️", "⭐️", "🛰", "🛸", "🚀", "🔭"],
                          ["🇯🇵", "🇺🇿", "🇺🇸", "🇰🇷", "🇰🇿", "🇩🇪", "🇷🇺", "🇨🇦", "🇬🇧"],
                          ["🍏", "🍎", "🍌", "🍋", "🫐", "🍉", "🍓", "🥝", "🍒"],
                          ["🚗", "🏎", "🚲", "🚄", "🚂", "🚁", "🛳", "🚢", "🏍"],
                          ["⌚️", "💻", "📱", "📷", "🕹", "🎛", "🪛", "💡", "🔋"]]
        
        let backgroundColorsCollection = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.01915666461, green: 0.1394926906, blue: 0.9948014617, alpha: 1)]
        let cardColorsCollection =       [#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)]
        
        let index = Int(arc4random_uniform(UInt32(collection.count)))
        
        return (collection[index], backgroundColorsCollection[index], cardColorsCollection[index])
    }
    
    
    func cornerRadius() {
        for view in cardButtons {
            view.layer.cornerRadius = 11.0
        }
    }
    
    
}

