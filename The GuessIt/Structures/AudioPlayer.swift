//
//  AudioPlayer.swift
//  The Guess
//
//  Created by Nick on 16.02.2021.
//

import AVFoundation


/// Class for control the Background Music Status
class Music {
    static let sharedInstance = Music()
    private var player: AVAudioPlayer?
    
    //Turn On the Background Music
    func play() {
        guard let url = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.numberOfLoops = -1
            guard let player = player else { return }
            
            player.play()
            
        } catch { print("Background Music is not found") }
    }
    
    //Stop the Background Music
    func stop() {
        player?.stop()
    }
}

class SoundEffects {
    static let sharedInstance = SoundEffects()
    private var player: AVAudioPlayer?

    
    //Play the Sound effect
    func play() {
        guard let url = Bundle.main.url(forResource: "buttonClick", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            
            player.play()
            
        } catch { print("Background Music is not found") }
    }
}
