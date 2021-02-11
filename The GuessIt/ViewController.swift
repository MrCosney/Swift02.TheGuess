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
    
    //MARK: - Methods
    /// Create And Setup Interface Buttons
    private func createButtons() {
        let scaler = min(view.bounds.height, view.bounds.width)
        let viewButtons = [UIButton(),startButton, optionButton, UIButton()]
        let viewButtonsName = ["", "Start", "Options", ""]

        for i in 0..<viewButtons.count {
            if viewButtonsName[i] != "" {
                viewButtons[i].setTitleColor(.black, for: [])
                viewButtons[i].backgroundColor = .yellow
                viewButtons[i].layer.cornerRadius = 50
                viewButtons[i].tintColor = .black
                viewButtons[i].titleLabel?.font = UIFont.boldSystemFont(ofSize: scaler / 15)
                viewButtons[i].setTitle(viewButtonsName[i], for: [])
                viewButtons[i].titleLabel?.textAlignment = .center
                viewButtons[i].translatesAutoresizingMaskIntoConstraints = false
            } else {viewButtons[i].isEnabled = false}
            bottomStackView.addArrangedSubview(viewButtons[i])
        }
        optionButton.addTarget(self, action: #selector(optionButtonPressed), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 20
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createButtons()
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
