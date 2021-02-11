//
//  OptionsViewController.swift
//  The GuessIt
//
//  Created by Nick on 10.02.2021.
//

import UIKit
import AVFoundation

class OptionsViewController: Main {
    
    //MARK: - Properties
    let voliumeLabel =        UILabel()
    let voliumeSwitch =       UISwitch()
    let buttonVoliumeLabel =  UILabel()
    let buttomVoliumeSwitch = UISwitch()
    let stackView =           UIStackView()
    var voliume: Int = 0
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        createReturnButton()
        createStackView()
    }
    
    private func createStackView() {
        stackView.addArrangedSubview(voliumeLabel)
        stackView.addArrangedSubview(voliumeSwitch)
        stackView.addArrangedSubview(buttonVoliumeLabel)
        stackView.addArrangedSubview(buttomVoliumeSwitch)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.backgroundColor = .black
        setupStackView()
        updateStackView(with: view.frame.size)
        view.addSubview(stackView)
    }
    
    private func setupStackView() {
        //MARK: TODO добавить размер switch от размера экрана
        
        let scaler = min(view.bounds.height, view.bounds.width)
        let labels = [voliumeLabel, buttonVoliumeLabel]
        let labelsText = ["Музыка", "Эффекты"]
        let switchers = [buttomVoliumeSwitch, voliumeSwitch]
        
        //Setup Each Option Label
        for i in 0..<labels.count {
            labels[i].font = UIFont.boldSystemFont(ofSize: scaler / 15)
            labels[i].text = labelsText[i]
            labels[i].textColor = .white
        }
        print(view.bounds.size.height / 51)
        //Setup Each Switcher
        for switcher in switchers{
            switcher.tintColor = .red
            switcher.onTintColor = .red
            //switcher.transform = CGAffineTransform(scaleX: (view.bounds.size.width / 51) / 15, y: (view.bounds.size.height / 31) / 15)
        }
    }
    private func updateStackView(with size: CGSize) {
        stackView.frame = CGRect(x: size.width / 4 ,
                                 y: size.height / 4,
                                 width: size.width / 2 ,
                                 height: size.height / 2 )
    }
    
    @objc func pushButton() {
        //move it to superclass
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound)
            audioPlayer.play()
        } catch {}
        navigationController?.popViewController(animated: true)
    }
    
    override func updateUI(to size: CGSize) {
        updateReturnButton()
        updateStackView(with: size)
    }
}

