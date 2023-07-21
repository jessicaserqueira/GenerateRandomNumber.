//
//  RandomNumberPresenter.swift
//  GenerateRandomNumber
//
//  Created by Jessica Serqueira on 17/07/23.
//

import Foundation

protocol RandomNumberViewModelDelegate: AnyObject{
    func numberGenerated(_ number: Int)
    func showLessThanNumberAlert()
    func showGreaterThanNumberAlert()
    func showWinAlerts(with attempts: Int)
    func showBoundsAlerts()
    func showExceededAttemptsAlert()
}

class RandomNumberViewModel {
    
    private var view: RandomNumberView
    weak var delegate: RandomNumberViewModelDelegate?
    
    private var numberToGuess: Int?
    private var maxNumberOfGuesses = 3
    private var currentGuesses = 0
    var isGameOver = false
    
    init(view: RandomNumberView) {
        self.view = view
    }
    
    func generateRandomNumber() {
        numberToGuess = Int.random(in: 1...10)
        currentGuesses = 0
        isGameOver = false
        delegate?.numberGenerated(numberToGuess ?? 0)
    }
    
    func validateGuess(_ guess: Int) {
        guard !isGameOver, let numberToGuess = numberToGuess else { return }
        
        if currentGuesses >= maxNumberOfGuesses {
            delegate?.showExceededAttemptsAlert()
            isGameOver = true
        }
        
        currentGuesses += 1
        
        if guess < 1 || guess > 10 {
            delegate?.showBoundsAlerts()
        } else if guess < numberToGuess {
            delegate?.showLessThanNumberAlert()
        } else if guess > numberToGuess {
            delegate?.showGreaterThanNumberAlert()
        } else {
            delegate?.showWinAlerts(with: currentGuesses)
            isGameOver = true
            resetGame()
            generateRandomNumber()
        }
    }
    
    private func resetGame() {
        currentGuesses = 0
        isGameOver = false
    }
}
