//
//  GameSetupViewController.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit
import AVFoundation

class GameSetupViewController: Main {
    
    let buttonTitles = ["", "Легкий", "Cредний", "Сложный", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topStackView)
        setupButtons()
        setupStackViews()
        createReturnButton()
        updateUI(to: view.bounds.size)
    }
    
    private func setupButtons() {
        //FIXME: Make it more easier
        let buttonArray = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
        
        createButtons(buttons: buttonArray, titles: buttonTitles)
        for button in buttonArray {
            if button.titleLabel?.text != "" {
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Легкий": Main.incorrectMovesAllowed = 7
        case "Cредний": Main.incorrectMovesAllowed = 6
        case "Сложный": Main.incorrectMovesAllowed = 5
        default: fatalError()
        }
        navigationController?.pushViewController(GameViewController(), animated: false)
    }
}

