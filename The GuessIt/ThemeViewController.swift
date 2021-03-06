//
//  GameThemeViewController.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit


/// Controller for Setup the Theme Of the Words in the Game
class ThemeViewController: BaseViewController {
    //MARK: - Properties
    var viewButtons: [UIButton] = []
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topStackView)
        setupButtons()
        setupStackViews()
        createReturnButton()
        updateUI(to: view.bounds.size)
    }
    
    /// Create And Setup Interface Buttons
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
    @objc private func buttonPressed(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Столицы": BaseViewController.listOfWords = Words.capitals
        case "Автомобили": BaseViewController.listOfWords = Words.auto
        case "Покемоны": BaseViewController.listOfWords = Words.pokemons
        default: fatalError()
        }
        
        playButtonSound()
        navigationController?.pushViewController(SetupViewController(), animated: false)
    }
}
