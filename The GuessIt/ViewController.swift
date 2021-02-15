//
//  ViewController.swift
//  The GuessIt
//
//  Created by Nick on 10.02.2021.
//

import UIKit

class ViewController: Main {

    //MARK: - Properties
    var viewButtons: [UIButton] = []
    
    //MARK: - Methods
    /// Create And Setup Interface Buttons
    private func setupButtons() {
        createButtons(buttons: &viewButtons, titles: Words.menuButtons)
        for button in viewButtons {
            if button.titleLabel?.text == "Начать игру" {
                button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
            } else if button.titleLabel?.text == "Настройки" {
                button.addTarget(self, action: #selector(optionButtonPressed), for: .touchUpInside)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Calculate Font Size For Button's lables
        Main.fontScaler = min(view.bounds.size.width, view.bounds.size.height) / 20
        
        setupButtons()
        setupStackViews()
        view.addSubview(topStackView)
        updateUI(to: view.bounds.size)
    }
    
    @objc func optionButtonPressed() {
        navigationController?.pushViewController(OptionsViewController(), animated: true)
    }
    @objc func startButtonPressed() {
        navigationController?.pushViewController(GameThemeViewController(), animated: false)
    }
}
