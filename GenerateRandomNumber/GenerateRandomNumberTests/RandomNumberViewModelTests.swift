//
//  GenerateRandomNumberTests.swift
//  GenerateRandomNumberTests
//
//  Created by Jessica Serqueira on 17/07/23.
//

import XCTest
@testable import GenerateRandomNumber

class RandomNumberViewModelTests: XCTestCase {
    
    var viewModel: RandomNumberViewModel!
    var delegateMock: RandomNumberViewModelDelegateMock!
    
    override func setUpWithError() throws {
        delegateMock = RandomNumberViewModelDelegateMock()
        viewModel = RandomNumberViewModel()
        viewModel.delegate = delegateMock
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        delegateMock = nil
    }
    
    func testValidateGuessLowerThanNumber() {
        viewModel.generateRandomNumber()
        let guess = viewModel.numberToGuess! - 1
        
        viewModel.validateGuess(guess)
        
        XCTAssertTrue(delegateMock.showLessThanNumberAlertCalled, "O método delegado showLessThanNumberAlert() deve ser chamado quando o palpite for menor que o numberToGuess")
        
    }
    
    func testValidateGuessGreaterThanNumber() {
        viewModel.generateRandomNumber()
        let guess = viewModel.numberToGuess! + 1
        viewModel.validateGuess(guess)
        
        XCTAssertTrue(delegateMock.showGreaterThanNumberAlertCalled, "O método delegado showGreaterThanNumberAlert() deve ser chamado quando o palpite for maior que o numberToGuess")
    }
    
    func testValidateGuessCorrectNumber() {
        viewModel.generateRandomNumber()
        let guess = viewModel.numberToGuess!
        
        viewModel.validateGuess(guess)
        
        XCTAssertTrue(delegateMock.showWinAlertsCalled, "O método delegado showWinAlerts() deve ser chamado quando o palpite corresponder ao numberToGuess")
        XCTAssertEqual(delegateMock.attempts, 1, "O método delegado showWinAlerts() deve ser chamado com o número correto de tentativas (1)")
        XCTAssertTrue(viewModel.isGameOver, "O isGameOver deve ser verdadeiro quando o palpite corresponder ao numberToGuess")
    }
    
    func testValidateGuessMaxAttemptsReached() {
        viewModel.generateRandomNumber()
        
        let guess1 = viewModel.numberToGuess! - 1
        let guess2 = viewModel.numberToGuess! + 1
        
        viewModel.validateGuess(guess1)
        
        XCTAssertFalse(viewModel.isGameOver, "O isGameOver deve permanecer falso após o primeiro palpite incorreto")
        XCTAssertFalse(delegateMock.showExceededAttemptsAlertCalled, "O método delegado showExceededAttemptsAlert() não deve ser chamado após o primeiro palpite incorreto")
        
        viewModel.validateGuess(guess2)
        
        if viewModel.currentGuesses >= viewModel.maxNumberOfGuesses {
            XCTAssertTrue(viewModel.isGameOver, "O isGameOver deve ser verdadeiro após o palpite incorreto atingir o máximo de tentativas")
            XCTAssertTrue(delegateMock.showExceededAttemptsAlertCalled, "O método delegado showExceededAttemptsAlert() deve ser chamado após o palpite incorreto atingir o máximo de tentativas")
        } else {
            XCTAssertFalse(viewModel.isGameOver, "O isGameOver deve permanecer falso após o segundo palpite incorreto")
            XCTAssertFalse(delegateMock.showExceededAttemptsAlertCalled, "O método delegado showExceededAttemptsAlert() não deve ser chamado após o segundo palpite incorreto")
        }
        
    }
}
