//
//  GameThemeViewController.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit
import AVFoundation

class GameThemeViewController: Main {

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
        createButtons(buttons: &viewButtons, titles: Words.themesButtons)
        for button in viewButtons {
            if button.titleLabel?.text != " " {
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }
    
    /// Setup the game Theme
    /// - Parameter sender: Button with the Game Theme
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Столицы": Main.listOfWords = Words.capitals
        case "Автомобили": Main.listOfWords = Words.auto
        case "Покемоны": Main.listOfWords = Words.pokemons
        default: fatalError()
        }
        //playButtonSound()
        navigationController?.pushViewController(GameSetupViewController(), animated: false)
    }
}
