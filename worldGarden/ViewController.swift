//
//  ViewController.swift
//  worldGarden
//
//  Created by cheng jiayi on 2020/1/29.
//  Copyright © 2020 cheng jiayi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    
    func updateUIAfterGuess() {
        guessLetterField.resignFirstResponder()
        guessLetterField.text = ""
       
    }
    
    func formatUserGuessLabel() {
         var revealedWord = ""
         lettersGuessed += guessLetterField.text!
     
         for letter in wordToGuess {
             if lettersGuessed.contains(letter){
                     revealedWord = revealedWord + " \(letter)"
             } else {
                       revealedWord += " _"
             }
         }
             revealedWord.removeFirst()
             userGuessLabel.text = revealedWord
     }
     
     func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        
        let currentLetterGuessed = guessLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
             wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        
        let revealedWord = userGuessLabel.text!
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessLetterButton.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "you are out of guesses. try again"
        }else if !revealedWord.contains("_") {
            playAgainButton.isHidden = false
            guessLetterButton.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "you got it! it took you \(guessCount) guesses"
        }else{
            let guess = ( guessCount == 1 ? "guess" : "guesses")
            guessCountLabel.text = "you've made \(guessCount) \(guess)!"
        }
     }
    
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessLetterField.text?.last {
            guessLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        }else {
            // disable the button is there is no cahracter in the text field
            guessLetterButton.isEnabled = false
        }
    }
    

    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    

    @IBAction func guessButtonPressed(_ sender: UIButton) {
        guessALetter()
       updateUIAfterGuess()
    }
    
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessLetterField.isHidden = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "you made 0 guess"
        guessCount = 0
    }
    
}

