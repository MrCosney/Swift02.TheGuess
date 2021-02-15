//
//  GameSetupViewController.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit
import AVFoundation

class GameSetupViewController: Main {
    
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
    
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Легкий": Main.incorrectMovesAllowed = 7
        case "Средний": Main.incorrectMovesAllowed = 6
        case "Сложный": Main.incorrectMovesAllowed = 5
        default: fatalError()
        }
        navigationController?.pushViewController(GameViewController(), animated: false)
    }
}

