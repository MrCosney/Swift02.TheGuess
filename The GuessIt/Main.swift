//
//  Main.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit
import AVFoundation

class Main: UIViewController {
    // Main Super Class
    
    //MARK: - Properties
    
    let imageView =          UIImageView()
    let returnButton =       UIButton()
    // Create StackView
    let topStackView =       UIStackView()
    let bottomStackView =    UIStackView()
    
    // Propeties for Audio 
    let sound = URL(fileURLWithPath: Bundle.main.path(forResource: "buttonSound", ofType: "mp3") ?? "nil")
    var audioPlayer = AVAudioPlayer()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Methods
    //MARK: - Create and Setup Return Button
    func createReturnButton() {
        returnButton.backgroundColor = .yellow
        view.addSubview(returnButton)
        updateReturnButton()
        returnButton.addTarget(self, action: #selector(returnButtonPressed), for: .touchUpInside)
    }
    
    func updateReturnButton() {
        //TODO: Find the corret position for button
        let scaler = min(view.bounds.size.width, view.bounds.size.height)
        returnButton.frame = CGRect(x: 25, y: 25, width: scaler / 5, height: scaler / 5)
    }

    @objc func returnButtonPressed() {
        //move it to superclass
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound)
            audioPlayer.play()
        } catch {}
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
        
        //Setup Bottom Stack View
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 20
        
        //Setup Image
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "1x")
    }
    
    //MARK: - Create And Setup Interface Buttons
//    func createButtons(buttons: [UIButton], titles: [String]) {
//        let scaler = min(view.bounds.height, view.bounds.width)
//
//        for i in 0..<buttons.count {
//            if titles[i] != "" {
//                buttons[i].setTitleColor(.black, for: [])
//                buttons[i].backgroundColor = .yellow
//                buttons[i].layer.cornerRadius = 50
//                buttons[i].tintColor = .black
//                buttons[i].titleLabel?.font = UIFont.boldSystemFont(ofSize: scaler / 15)
//                buttons[i].setTitle(titles[i], for: [])
//                buttons[i].titleLabel?.textAlignment = .center
//                buttons[i].translatesAutoresizingMaskIntoConstraints = false
//            } else {buttons[i].isEnabled = false}
//            bottomStackView.addArrangedSubview(buttons[i])
//        }
//    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(to: size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
