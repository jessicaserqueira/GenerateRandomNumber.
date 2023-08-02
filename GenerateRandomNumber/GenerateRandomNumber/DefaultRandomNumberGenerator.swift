//
//  DefaultRandomNumberGenerator.swift
//  GenerateRandomNumber
//
//  Created by Jessica Serqueira on 26/07/23.
//

import Foundation

class DefaultRandomNumberGenerator: RandomNumberGenerator {
    var numberToGuess: Int?
    
    var maxNumberOfGuesses: Int = 0
    
    var currentGuesses: Int = 0
    
    var isGameOver: Bool = false
    
    func generateRandomNumber() {
        numberToGuess = Int.random(in: 1...10)
        currentGuesses = 0
        isGameOver = false
    }
    
    func validateGuess(_ guess: Int) {
        guard let numberToGuess = numberToGuess else { return }
        
        currentGuesses += 1
        
        if currentGuesses >= maxNumberOfGuesses {
            isGameOver = true
        }
        
        if guess < 1 || guess > 10 {
     
        } else if guess < numberToGuess {
         
        } else if guess > numberToGuess {
          
        } else {
        
            isGameOver = true
        }
    }
}
