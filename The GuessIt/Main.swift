//
//  Main.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit
import AVFoundation

class Main: UIViewController {
    //MARK: - Properties
    public let imageView =          UIImageView()
    public let returnButton =       UIButton()
    // Create StackView
    public let bottomStackView =    UIStackView()
    public let topStackView =       UIStackView()
    // Game Properties
    //FIXME: Переделать в Enum?
    static var buttonsAlphobet = "_ЙЦУКЕНГШЩЗХЪЁ___ФЫВАПРОЛДЖЭ_____ЯЧСМИТЬБЮ___"
    static var incorrectMovesAllowed = 7
    static var listOfWords: [String] = []
    //Font Propetires calculates in first View controller
    static var fontScaler: CGFloat = 12
    
    // Propeties for Audio
    private var audioPlayer = AVAudioPlayer()
    private var audioType = "mp3"
    private var backgroundSound = "backgroundMusic"
    private var buttonSound = "buttonClick"
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Methods
    //MARK: - Create and Setup Return Button
    open func createReturnButton() {
        returnButton.setBackgroundImage(UIImage(named: "returnButton"), for: [])
        view.addSubview(returnButton)
        updateReturnButton()
        returnButton.addTarget(self, action: #selector(returnButtonPressed), for: .touchUpInside)
    }
    
    open func updateReturnButton() {
        //TODO: Find the corret position for button
        let sizeScaler = min(view.bounds.size.width, view.bounds.size.height)
        returnButton.frame = CGRect(x: 25, y: 25, width: sizeScaler / 5, height: sizeScaler / 5)
    }
    
    @objc open func returnButtonPressed() {
        //playButtonSound()
        navigationController?.popViewController(animated: false)
    }
    
    open func updateUI(to size: CGSize) {
        topStackView.axis = size.height < size.width ? .horizontal: .vertical
        topStackView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    //MARK: - Setup Stack Views
    open func setupStackViews() {
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
    //FIXME: Check is unout us correct usages
    open func createButtons(buttons: inout [UIButton] ,titles: [String]) {

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
                buttons[i].titleLabel?.font = UIFont(name: "Rockin\'-Record", size: Main.fontScaler)
                buttons[i].titleLabel?.textAlignment = .center
                buttons[i].translatesAutoresizingMaskIntoConstraints = false
            } else {buttons[i].isEnabled = false}
            bottomStackView.addArrangedSubview(buttons[i])
        }
    }
    //MARK: - Navigation and Transition Configuartion
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(to: size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    open func playSound() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:
                                            Bundle.main.path(forResource: backgroundSound, ofType: audioType)!))
            audioPlayer.numberOfLoops = -1 // Make it Infinite
            audioPlayer.prepareToPlay()
        } catch {print("Background Sound is not Found")}
        audioPlayer.play()
    }
    
    //FIXME: Fix button Sound
    open func playButtonSound() {
        do {
            let audioPath = Bundle.main.path(forResource: "buttonClick", ofType: audioType)
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!) as URL)

        } catch {print("Button Sound is not Found")}
        audioPlayer.play()
    }
    
    //FIXME: Is it needed??
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
