//
//  Game.swift
//  The Guess
//
//  Created by Nick on 12.02.2021.
//

/// Control the Guess Process(check the correct letter and compare it to true one)
struct Game {
    var currentWord: String
    var movesRemaining: Int
    fileprivate var guessedLetters = [Character]()
    
    init(word: String, movesRemaining: Int) {
        self.currentWord = word
        self.movesRemaining = movesRemaining
    }
    
    var guessedWord: String {
        var wordToDisplay = ""
        for letter in currentWord {
            if guessedLetters.contains(Character(letter.lowercased())) || letter == "-" || letter == " " {
                wordToDisplay += String(letter)
            } else { wordToDisplay += "_" }
        }
        return wordToDisplay
    }
    
    mutating func guess(letter: Character) {
        let lowLetter = Character(letter.lowercased())
        guessedLetters.append(lowLetter)
        if !currentWord.lowercased().contains(lowLetter) {
            movesRemaining -= 1
        }
    }
}
