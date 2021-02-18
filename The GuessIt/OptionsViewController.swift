//
//  OptionsViewController.swift
//  The GuessIt
//
//  Created by Nick on 10.02.2021.
//

import UIKit

/// Controller for Setup the Music Options (Music/Effects) in the App
class OptionsViewController: BaseViewController {
    
    //MARK: - Properties
    let optionsTitles = ["Музыка", "Эффекты"]
    let stackView = UIStackView()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        createReturnButton()
        createStackView()
    }
    
    private func createStackView() {
        setupOptionsStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        updateStackView(with: view.frame.size)
    }
    
    /// Create And Setup Labels and Switchers in Option Controller
    private func setupOptionsStackView() {
        
        //Setup Each Option Label
        for title in optionsTitles {
            let label = UILabel()
            label.text = title
            label.textColor = .black
            label.font = UIFont(name: customFont, size: BaseViewController.fontScaler + 5)
            stackView.addArrangedSubview(label)
            
            //Setup Each Switcher
            let switcher = UISwitch()
            switcher.onTintColor = .black
            switcher.thumbTintColor = .yellow
            switcher.accessibilityIdentifier = title
            switcher.addTarget(self, action: #selector(didChangeSwitcher), for: .valueChanged)
            stackView.addArrangedSubview(switcher)
            
            //Setup current Switcher Status
            if switcher.accessibilityIdentifier == "Музыка" {
                switcher.isOn = BaseViewController.musicIsOn
            } else {
                switcher.isOn = BaseViewController.effectsIsOn
            }
        }
    }
    @objc private func didChangeSwitcher(_ sender: UISwitch) {
        
        //Turn On/Off the Background Music
        if sender.accessibilityIdentifier == "Музыка" {
            if sender.isOn == false { Music.sharedInstance.stop() }
            else { Music.sharedInstance.play() }
            BaseViewController.musicIsOn.toggle()
        } else {
            //Turn On/Off the sound effects
            BaseViewController.effectsIsOn.toggle()
        }
    }
    
    //MARK: - Update Interface
    private func updateStackView(with size: CGSize) {
        stackView.frame = CGRect(x: size.width / 4 ,
                                 y: size.height / 4,
                                 width: size.width / 2 ,
                                 height: size.height / 2 )
    }
    
    override func updateUI(to size: CGSize) {
        updateReturnButton(to: size)
        updateStackView(with: size)
    }
}

