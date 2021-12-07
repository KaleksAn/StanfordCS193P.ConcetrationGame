//
//  ViewController.swift
//  StanfordCS193P.Part_I,II,III
//
//  Created by Aleksandr Kan on 24.11.2021.
//

import UIKit

class ViewController: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    private var game: Concetration!
    var numberOfPairsCards: Int { return (cardButtons.count + 1) / 2 }
    var colors: ( backgroundColor: UIColor, generalColor: UIColor)!
    var emojiChoices: [String]!
    var emoji: [Int: String]!
    var colorForCard: UIColor!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var newGameLabel: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        game = Concetration(numberOfPairsCards: numberOfPairsCards)
        colors = colorFactory()
        setEmoji()
        setColor(forBackground: colors.backgroundColor, andCard: colors.generalColor)
        setLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cornerRadius()
    }
    
    
    @IBAction private func touchNewGame(_ sender: UIButton) {
        game.resetGame()
        updateViewFromModel()
        
        colors = colorFactory() // Метод создаёт два случайных цвета
        setEmoji() //Выбор и установка случайного набора эмоджи
        setColor(forBackground: colors.backgroundColor, andCard: colors.generalColor) // Установка цвета
        setLabel()
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 0) : colorForCard
            }
        }
    }
    
    
   private  func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            
            var randomIndex: Int {
                let numberCount = UInt32(emojiChoices.count)
                let randomNumber = arc4random_uniform(numberCount)
                return Int(randomNumber)
            }
            
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
    private func colorFactory() -> (UIColor, UIColor) {
        let backgroundColorsCollection = UIColor(displayP3Red: .random(in: 0.0...0.2), green: .random(in: 0.0...0.2), blue: .random(in: 0.0...0.3), alpha: 1.0)
        let generalColorsCollection =  UIColor(hue: .random(in: 0.0...1.0), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        return (backgroundColorsCollection, generalColorsCollection)
    }
    
    private func setColor(forBackground backViewColor: UIColor, andCard cardColor: UIColor) {
        cardButtons.forEach { button in button.backgroundColor = cardColor }
        colorForCard = cardColor
        newGameLabel.setTitleColor(cardColor, for: .normal)
        flipCountLabel.textColor = colors.generalColor
        scoreLabel.textColor = colors.generalColor
        view.backgroundColor = backViewColor
    }
    
    private func setLabel() {
        newGameLabel.setTitle("New GAME", for: .normal)
        newGameLabel.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
        scoreLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
        flipCountLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    private func setEmoji() {
        emoji = [:]
        var index : Int {
            get {
                let count = UInt32(collection.count)
                let randomNumber = arc4random_uniform(count)
                return Int(randomNumber)
            }
        }
        
        let collection = [["🎃", "👻", "🦇", "😈", "🍭", "🙀", "😱", "🍎", "🧛‍♂️"],
                          ["🤖", "👽", "👩🏻‍🚀", "☄️", "⭐️", "🛰", "🛸", "🚀", "🔭"],
                          ["🇯🇵", "🇺🇿", "🇺🇸", "🇰🇷", "🇰🇿", "🇩🇪", "🇷🇺", "🇨🇦", "🇬🇧"],
                          ["🍏", "🍎", "🍌", "🍋", "🫐", "🍉", "🍓", "🥝", "🍒"],
                          ["🚗", "🏎", "🚲", "🚄", "🚂", "🚁", "🛳", "🚢", "🏍"],
                          ["⌚️", "💻", "📱", "📷", "🕹", "🎛", "🪛", "💡", "🔋"]]
        
        
        emojiChoices = collection[index]
    }
    
    private func cornerRadius() {
        for view in cardButtons {
            view.layer.cornerRadius = 11.0
        }
    }
    
    
}

