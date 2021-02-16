//
//  OptionsViewController.swift
//  The GuessIt
//
//  Created by Nick on 10.02.2021.
//

import UIKit
import AVFoundation

/// Controller for Setup the Music Options (Music/Effectins) in the App
class OptionsViewController: Main {
    
    //MARK: - Properties
    let voliumeLabel =        UILabel()
    let musicSwitch =       UISwitch()
    let buttonVoliumeLabel =  UILabel()
    let soundEffectSwitch = UISwitch()
    let stackView =           UIStackView()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        createReturnButton()
        createStackView()
    }
    
    private func createStackView() {
        setupOptinoStackView()
        stackView.addArrangedSubview(voliumeLabel)
        stackView.addArrangedSubview(musicSwitch)
        stackView.addArrangedSubview(buttonVoliumeLabel)
        stackView.addArrangedSubview(soundEffectSwitch)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        updateStackView(with: view.frame.size)
    }
    
    private func setupOptinoStackView() {
        //TODO: добавить размер switch от размера экрана

        let labels = [voliumeLabel, buttonVoliumeLabel]
        let labelsText = ["Музыка", "Эффекты"]
        let switchers = [musicSwitch, soundEffectSwitch]
        
        //Setup Each Option Label
        for i in 0..<labels.count {
            labels[i].text = labelsText[i]
            labels[i].textColor = .black
            labels[i].font = UIFont(name: "Rockin\'-Record", size: Main.fontScaler + 5)
        }
        //Setup Each Switcher
        for index in 0..<switchers.count {
            switchers[index].onTintColor = .black
            switchers[index].thumbTintColor = .yellow
            //switcher.backgroundColor = .red
            //switcher.layer.cornerRadius = 16
           // switcher.layer.masksToBounds = false
            switchers[index].accessibilityIdentifier = labelsText[index]
            switchers[index].addTarget(self, action: #selector(didChangeSwitcher), for: .valueChanged)
        }
        //Setup current Switcher Status
        musicSwitch.isOn = Main.musicIsOn
        soundEffectSwitch.isOn = Main.effecttsIsOn
    }
    @objc private func didChangeSwitcher(_ sender: UISwitch) {
        
        //Turn On/Off the Background Music
        if sender.accessibilityIdentifier == "Музыка" {
            if sender.isOn == false {Music.sharedInstance.stop()}
            else {Music.sharedInstance.play()}
            Main.musicIsOn.toggle()
        } else {
        //Turn On/Off the sound effects
            Main.effecttsIsOn.toggle()
        }
    }
    
    private func updateStackView(with size: CGSize) {
        stackView.frame = CGRect(x: size.width / 4 ,
                                 y: size.height / 4,
                                 width: size.width / 2 ,
                                 height: size.height / 2 )
    }

    override func updateUI(to size: CGSize) {
        updateReturnButton()
        updateStackView(with: size)
    }
}

