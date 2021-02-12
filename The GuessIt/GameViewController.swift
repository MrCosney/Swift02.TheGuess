//
//  GameViewController.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit
import AVFoundation

class GameViewController: Main {
    //MARK: - Properties
    let buttonsView =           UIStackView()
    let correctWordLabel =      UILabel()
    var currentRound:           Game!
    var letterButtons =         [UIButton]()
    let scoreLabel =            UILabel()
    
    //Game Status Properties
    var totalWins: Int = 0 {
        didSet {newRound()}
    }
    var totalLosses: Int = 0 {
        didSet {newRound()}
    }
    
    //MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    /// Setup the NewRound of the Game.
    func newRound() {
        let newWord = Main.listOfWords.removeFirst()
        
        guard !Main.listOfWords.isEmpty else {
            enableButtons(false)
            updateGameInterface()
            return
        }
        print(newWord)
        currentRound = Game(word: newWord, movesRemaining: Main.incorrectMovesAllowed)
        updateGameInterface()
        enableButtons()
    }
    
    func updateCorrectWordLabel() {
        var displayWord = [String]()
        
        for letter in currentRound.guessedWord {
            displayWord.append(String(letter))
        }
        correctWordLabel.tintColor = .white
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    /// Update the current User's Wins Losses status
    func updateState() {
        if currentRound.movesRemaining < 1 {
            totalLosses += 1
        } else if currentRound.guessedWord == currentRound.currentWord {
            totalWins += 1
        } else {updateGameInterface()}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topStackView)
        createLetterButtons()
        setupStackViews()
        setupBottomView()
        topStackView.backgroundColor = .white
        createReturnButton()
        updateUI(to: view.bounds.size)
        newRound()
    }
    
    /// Insert Buttons And Labels in Bottom StackView
    private func setupBottomView() {
        //Setup scorelabel
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.boldSystemFont(ofSize: Main.fontScaler - 3)
        
        //Setup correct word Label
        correctWordLabel.textColor = .black
        correctWordLabel.textAlignment = .center
        correctWordLabel.font = UIFont.boldSystemFont(ofSize: Main.fontScaler + 3)
        
        bottomStackView.addArrangedSubview(correctWordLabel)
        bottomStackView.addArrangedSubview(buttonsView)
        bottomStackView.addArrangedSubview(scoreLabel)
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 0
        
        buttonsView.distribution = .fillProportionally
        buttonsView.axis = .vertical
    }
    
    /// Create buttons for guess In Buttom Stack View
    private func createLetterButtons() {
        let buttonTitles = "ЙЦУКЕНГШЩЗХЪЁ_ФЫВАПРОЛДЖЭ___ЯЧСМИТЬБЮ__"
        
        for buttonTitle in buttonTitles {
            let title = buttonTitle == "_" ? "": String(buttonTitle)
            let button = UIButton()
            if title != "_"{
                button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            }
            button.setTitle(title, for: .normal)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Main.fontScaler)
            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(.gray, for: .disabled)
            
            letterButtons.append(button)
        }
        
        let buttonRows = [UIStackView(), UIStackView(), UIStackView()]
        let rowCount = letterButtons.count / 3
        
        for row in 0..<buttonRows.count {
            for index in 0..<rowCount {
                buttonRows[row].addArrangedSubview(letterButtons[row * rowCount + index])
            }
            buttonRows[row].distribution = .fillEqually
            buttonsView.addArrangedSubview(buttonRows[row])
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        let letter = sender.title(for: .normal)!
        currentRound.guess(letter: Character(letter))
        updateState()
    }
    
    private func updateGameInterface() {
        let movesRemaining = currentRound.movesRemaining
        let imageNumber = (movesRemaining + 64) % 8
        let image = "Doodle\(imageNumber)"
        imageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.font = UIFont.boldSystemFont(ofSize: Main.fontScaler)
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLosses)"
    }
}
