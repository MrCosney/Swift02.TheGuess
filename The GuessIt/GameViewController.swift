//
//  GameViewController.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit

class GameViewController: BaseViewController {
    //MARK: - Properties
    private let buttonsView = UIStackView()
    private let correctWordLabel = UILabel()
    private var currentRound: Game!
    private var letterButtons = [UIButton]()
    private var listOfWords = BaseViewController.listOfWords.shuffled()
    private let scoreLabel = UILabel()
    
    //          Properties for Refresh Screen
    private let refreshButton = UIButton()
    private let refreshLabel = UILabel()
    //Blur effect when the Game is Over
    private let blurEffect: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .prominent)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Game Status Properties
    private var totalWins: Int = 0 {
        didSet {
            if totalWins > 0 { newRound() }
        }
    }
    private var totalLosses: Int = 0 {
        didSet {
            if totalLosses > 0 { newRound() }
        }
    }
    
    //MARK: - Methods
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
    
    @objc private func buttonPressed(_ sender: UIButton) {
        let letter = sender.title(for: .normal)!
        
        sender.isEnabled = false
        playButtonSound()
        currentRound.guess(letter: Character(letter))
        updateState()
    }
    
    // Create Custom Keyboard for Game
    private func createLetterButtons() {
        
        for buttonTitle in BaseViewController.buttonsAlphabet {
            let title = buttonTitle == "_" ? "": String(buttonTitle)
            let button = UIButton()
            if title != ""{
                button.setBackgroundImage(UIImage(named: "letterButtonActive"), for: .normal)
                button.setBackgroundImage(UIImage(named: "letterButtonDisabled"), for: .disabled)
                button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            }
            button.setTitle(title, for: .normal)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: BaseViewController.fontScaler - 7)
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
    
    /// Enable/Disable Buttons for guess the Words
    private func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
        if enable == false {
            showRefreshMenu()
            
        }
    }
    
    /// Setup the NewRound of the Game.
    private func newRound() {
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updateGameInterface()
            return
        }
        
        let newWord = listOfWords.removeFirst()
        currentRound = Game(word: newWord, movesRemaining: BaseViewController.incorrectMovesAllowed)
        updateGameInterface()
        enableButtons()
    }
    
    /// Insert Buttons And Labels in Bottom StackView
    private func setupBottomView() {
        //Setup scorelabel
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.boldSystemFont(ofSize: BaseViewController.fontScaler - 3)
        
        //Setup correct word Label
        correctWordLabel.textColor = .black
        correctWordLabel.textAlignment = .center
        correctWordLabel.font = UIFont.boldSystemFont(ofSize: BaseViewController.fontScaler + 3)
        
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
    
    ///Update the All View Labels
    private func updateGameInterface() {
        let movesRemaining = currentRound.movesRemaining
        let imageNumber = (movesRemaining + 64) % 8
        let image = "Doodle\(imageNumber)"
        imageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.font = UIFont(name: customFont, size: BaseViewController.fontScaler)
        scoreLabel.text = "Побед: \(totalWins)   |   Поражений:  \(totalLosses)"
    }
    
    /// Update the current User's Wins Losses status
    private func updateState() {
        if currentRound.movesRemaining < 1 {
            totalLosses += 1
        } else if currentRound.guessedWord == currentRound.currentWord {
            totalWins += 1
        } else {updateGameInterface()}
    }
    
    override func updateUI(to size: CGSize) {
        topStackView.axis = size.height < size.width ? .horizontal: .vertical
        topStackView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        updateReturnButton(to: size)
        updateRefreshMenu(to: size)
    }
    //MARK: - Create The Refresh Menu
    /// Blur the Screen And Show the Refresh menu when Game is Over(List of Words is Empty).
    private func showRefreshMenu() {
        view.addSubview(blurEffect)
        view.addSubview(refreshButton)
        view.addSubview(refreshLabel)
        
        updateRefreshMenu(to: view.bounds.size)
        
        //Setup Refresh Button
        refreshButton.setTitleColor(.black, for: [])
        refreshButton.setTitle("Рестарт", for: [])
        refreshButton.layer.cornerRadius = 50
        refreshButton.titleLabel?.textAlignment = .center
        refreshButton.contentMode = .scaleAspectFill
        refreshButton.setBackgroundImage(UIImage(named: "start"), for: [])
        refreshButton.titleLabel?.font = UIFont(name: customFont, size: BaseViewController.fontScaler)
        refreshButton.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
        
        //Setup Refresh Label
        refreshLabel.text = "Конец игры"
        refreshLabel.font = UIFont(name: customFont, size: BaseViewController.fontScaler + 5)
        refreshLabel.textColor = .black
        refreshLabel.textAlignment = .center
        
        //Blur the background Screen
        blurEffect.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurEffect.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        blurEffect.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurEffect.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        blurEffect.alpha = 0.7
    }
    
    private func updateRefreshMenu(to size: CGSize) {
        let width = size.width / 2
        let height = min(size.width, size.height) / 5
        
        refreshButton.frame = CGRect(x: size.width / 4,
                                     y: size.height / 2,
                                     width: width,
                                     height: height)
        
        refreshLabel.frame = CGRect(x: size.width / 4,
                                    y: size.height / 2 - height,
                                    width: width,
                                    height: height / 2)
    }
    
    //Setup Restart the Game. (shuffle the words and reset the labels)
    @objc private func refreshButtonPressed() {
        //Remove Refresh Menu
        blurEffect.removeFromSuperview()
        refreshButton.removeFromSuperview()
        refreshLabel.removeFromSuperview()
        
        //Refresh List of Words and Start the New Game
        listOfWords = BaseViewController.listOfWords.shuffled()
        totalWins = 0
        totalLosses = 0
        newRound()
    }
}
