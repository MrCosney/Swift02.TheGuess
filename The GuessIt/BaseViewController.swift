//
//  Main.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit

class BaseViewController: UIViewController {
    //MARK: - Properties
    let customFont = "Rockin\'-Record"
    let imageView = UIImageView()
    let returnButton = UIButton()
    // Create StackView
    let bottomStackView = UIStackView()
    let topStackView = UIStackView()
    // Game Properties
    static var buttonsAlphabet = "_ЙЦУКЕНГШЩЗХЪЁ___ФЫВАПРОЛДЖЭ_____ЯЧСМИТЬБЮ___"
    static var incorrectMovesAllowed = 7
    static var listOfWords: [String] = []
    //Font Properties calculates in first View controller
    static var fontScaler: CGFloat = 12
    //Option Switcher state
    static var musicIsOn = true
    static var effectsIsOn = true
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Methods
    //MARK: - Create and Setup Return Button
    func createReturnButton() {
        returnButton.setBackgroundImage(UIImage(named: "returnButton"), for: [])
        view.addSubview(returnButton)
        updateReturnButton()
        returnButton.addTarget(self, action: #selector(returnButtonPressed), for: .touchUpInside)
    }
    
    func updateReturnButton() {
        //TODO: Find the correct position for button
        let sizeScaler = min(view.bounds.size.width, view.bounds.size.height)
        returnButton.frame = CGRect(x: 25, y: 25, width: sizeScaler / 5, height: sizeScaler / 5)
    }
    
    @objc open func returnButtonPressed() {
        playButtonSound()
        navigationController?.popViewController(animated: false)
    }
    
    func updateUI(to size: CGSize) {
        topStackView.axis = size.height < size.width ? .horizontal: .vertical
        topStackView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    //MARK: - Setup Stack Views
    func setupStackViews() {
        topStackView.addArrangedSubview(imageView)
        topStackView.addArrangedSubview(bottomStackView)
        topStackView.distribution = .fillEqually
        topStackView.frame = view.bounds
        topStackView.axis = .vertical
        topStackView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        //Setup Bottom Stack View
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 20
        
        //Setup Image
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "mainImage")
        
    }
    
    //MARK: - Create And Setup Interface Buttons
    func createButtons(buttons: inout [UIButton] ,titles: [String]) {
        
        //Add buttons depend on titles count + 1st and last empty buttons
        for _ in 0..<titles.count{
            buttons.append(UIButton())
        }
        
        for i in 0..<buttons.count {
            buttons[i].setTitle(titles[i], for: [])
            if buttons[i].titleLabel?.text != " " {
                buttons[i].setTitleColor(.black, for: [])
                buttons[i].setBackgroundImage(UIImage(named: "start"), for: [])
                buttons[i].contentMode = .scaleAspectFill
                buttons[i].layer.cornerRadius = 50
                buttons[i].tintColor = .white
                buttons[i].titleLabel?.font = UIFont(name: customFont, size: BaseViewController.fontScaler)
                buttons[i].titleLabel?.textAlignment = .center
                buttons[i].translatesAutoresizingMaskIntoConstraints = false
            } else { buttons[i].isEnabled = false }
            bottomStackView.addArrangedSubview(buttons[i])
        }
    }
    //MARK: - Buttons Sound Effect
    func playButtonSound() {
        // Check if Option Effects Switch Is on
        guard BaseViewController.effectsIsOn else { return }
        SoundEffects.sharedInstance.play()
    }
    
    //MARK: - Navigation and Transition Configuration
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(to: size)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
