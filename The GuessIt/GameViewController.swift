//
//  GameViewController.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit

class GameViewController: Main {
    //MARK: - Properties
    //FIXME: - Нужны ли private  на переменных?
    private let buttonsView =           UIStackView()
    private let correctWordLabel =      UILabel()
    private var currentRound:           Game!
    private var letterButtons =         [UIButton]()
    private var listOfWords =           Main.listOfWords.shuffled()
    private let scoreLabel =            UILabel()
    
    //Game Status Properties
    private var totalWins: Int = 0 {
        didSet {newRound()}
    }
    private var totalLosses: Int = 0 {
        didSet {newRound()}
    }
    
    //MARK: - Methods
    @objc private func buttonPressed(_ sender: UIButton) {
        let letter = sender.title(for: .normal)!
   
        sender.isEnabled = false
        playButtonSound()
        currentRound.guess(letter: Character(letter))
        updateState()
    }
    
    private func createLetterButtons() {
        
        for buttonTitle in Main.buttonsAlphobet {
            let title = buttonTitle == "_" ? "": String(buttonTitle)
            let button = UIButton()
            if title != ""{
                button.setBackgroundImage(UIImage(named: "letterButtonActive"), for: .normal)
                button.setBackgroundImage(UIImage(named: "letterButtonDisabled"), for: .disabled)
                button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            }
            button.setTitle(title, for: .normal)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Main.fontScaler - 7)
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
    
    ///Enable / Disable Buttons for guess the Words
    private func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
                button.isEnabled = enable
        }
    }
    
    /// Setup the NewRound of the Game.
    private func newRound() {
        //isGameFinished()
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updateGameInterface()
            return
        }
        
        let newWord = listOfWords.removeFirst()
        currentRound = Game(word: newWord, movesRemaining: Main.incorrectMovesAllowed)
        updateGameInterface()
        enableButtons()
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
        
        //Setup the Bottom View
        bottomStackView.addArrangedSubview(correctWordLabel)
        bottomStackView.addArrangedSubview(buttonsView)
        bottomStackView.addArrangedSubview(scoreLabel)
        bottomStackView.distribution = .fillEqually
        
        buttonsView.distribution = .fillProportionally
        buttonsView.axis = .vertical
    }
    //MARK: - Interface Updaters
    /// Update word to Guess Progress Label
    private func updateCorrectWordLabel() {
        var displayWord = [String]()
        
        for letter in currentRound.guessedWord {
            displayWord.append(String(letter))
        }
        correctWordLabel.tintColor = .white
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    private func updateGameInterface() {
        let movesRemaining = currentRound.movesRemaining
        let imageNumber = (movesRemaining + 64) % 8
        let image = "Doodle\(imageNumber)"
        imageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.font = UIFont.boldSystemFont(ofSize: Main.fontScaler)
        scoreLabel.text = "Побед: \(totalWins).   Поражений: \(totalLosses)"
    }
    
    /// Update the current User's Wins Losses status
    private func updateState() {
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
        createReturnButton()
        updateUI(to: view.bounds.size)
        newRound()
    }
}
