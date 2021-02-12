//
//  ViewController.swift
//  The GuessIt
//
//  Created by Nick on 10.02.2021.
//

import UIKit

class ViewController: Main {

    //MARK: - Properties
    let startButton =  UIButton()
    let optionButton = UIButton()
    
    //FIXME: Make it more easier
    let buttonTitles = ["", "Старт", "Настройки", ""]
    
    //MARK: - Methods
    /// Create And Setup Interface Buttons
    private func setupButtons() {
        //FIXME: Make it more easier
        let buttonArray = [UIButton(), startButton, optionButton, UIButton()]
        
        createButtons(buttons: buttonArray, titles: buttonTitles)
        optionButton.addTarget(self, action: #selector(optionButtonPressed), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Calculate Font Size For Button's lables
        Main.fontScaler = min(view.bounds.size.width, view.bounds.size.height) / 20
        view.backgroundColor = .white
        setupButtons()
        setupStackViews()
        //startButton.setBackgroundImage(UIImage(named: "start"), for: [])
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
