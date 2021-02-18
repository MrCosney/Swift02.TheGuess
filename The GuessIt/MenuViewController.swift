//
//  ViewController.swift
//  The GuessIt
//
//  Created by Nick on 10.02.2021.
//

import UIKit

class MenuViewController: BaseViewController {
    
    //MARK: - Properties
    var viewButtons: [UIButton] = []
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Calculate Font Size For Button's labels
        BaseViewController.fontScaler = min(view.bounds.size.width, view.bounds.size.height) / 20
        
        Music.sharedInstance.play()
        setupButtons()
        setupStackViews()
        view.addSubview(topStackView)
        updateUI(to: view.bounds.size)
    }
    
    /// Create And Setup Interface Buttons
    private func setupButtons() {
        createButtons(buttons: &viewButtons, titles: Words.menuButtons)
        for button in viewButtons {
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
    }

    @objc private func buttonPressed(_ sender: UIButton) {
           playButtonSound()
        if sender.titleLabel?.text == "Начать игру" {
            navigationController?.pushViewController(ThemeViewController(), animated: false)
        } else {
            navigationController?.pushViewController(OptionsViewController(), animated: false)
        }
    }
}
