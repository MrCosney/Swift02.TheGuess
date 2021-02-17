//
//  GameSetupViewController.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit

/// Controller for Setup the Complexity of the Game
class SetupViewController: BaseViewController {
    
    var viewButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topStackView)
        setupButtons()
        setupStackViews()
        createReturnButton()
        updateUI(to: view.bounds.size)
    }
    
    private func setupButtons() {
        createButtons(buttons: &viewButtons, titles: Words.complexityButtons)
        for button in viewButtons {
            if button.titleLabel?.text != " " {
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }
    
    ///Setup the Game Complexity Based on the User Choice
    @objc private func buttonPressed(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Легкий": BaseViewController.incorrectMovesAllowed = 7
        case "Средний": BaseViewController.incorrectMovesAllowed = 6
        case "Сложный": BaseViewController.incorrectMovesAllowed = 5
        default: fatalError()
        }
        
        playButtonSound()
        navigationController?.pushViewController(GameViewController(), animated: false)
    }
}

