//
//  GameSetupViewController.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit
import AVFoundation

class GameSetupViewController: Main {
    
   // let topStackView = UIStackView()
    //let bottomStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topStackView)
        setupStackViews()
        createButtons()
        createReturnButton()
        updateUI(to: view.bounds.size)
        // Do any additional setup after loading the view.
    }
    private func createButtons() {
        let scaler = min(view.bounds.height, view.bounds.width)
        let viewButtons = [UIButton(),UIButton(),UIButton(), UIButton(), UIButton()]
        let viewButtonsName = ["", "Легкий", "Cредний", "Сложный", ""]

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
                viewButtons[i].addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            } else {viewButtons[i].isEnabled = false}
            bottomStackView.addArrangedSubview(viewButtons[i])
        }
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 20
    }

    @objc func buttonPressed() {
        navigationController?.pushViewController(GameViewController(), animated: false)
    }
}

