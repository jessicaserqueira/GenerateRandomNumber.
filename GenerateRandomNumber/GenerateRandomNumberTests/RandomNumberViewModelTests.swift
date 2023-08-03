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
    var delegateMock: RandomNumberViewModelDelegateSpy!
    
    override func setUpWithError() throws {
        delegateMock = RandomNumberViewModelDelegateSpy()
        viewModel = RandomNumberViewModel(randomNumber: GeneretorNumberStub.self)
        viewModel.delegate = delegateMock
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        delegateMock = nil
    }
    
    func testGenereteRandomNumber() {
        viewModel.generateRandomNumber()
        
        XCTAssertTrue(delegateMock.numberGeneratedCalled)
        XCTAssertEqual(viewModel.numberToGuess, 8)
        XCTAssertFalse(viewModel.isGameOver)
        XCTAssertEqual(viewModel.currentGuesses, 0)
    }
    
    func testValidateGuessWin() {
        viewModel.generateRandomNumber()
        
        guard let guess = viewModel.numberToGuess else { return }
        
        viewModel.validateGuess(guess)
        
        XCTAssertTrue(delegateMock.showWinAlertsCalled)
        XCTAssertEqual(viewModel.numberToGuess, 8)
        XCTAssertEqual(delegateMock.attempts, 1)
        XCTAssertTrue(viewModel.isGameOver)
    }
    
    func testValidateGuessExceededAttempts() {
        viewModel.generateRandomNumber()
        
        guard let guess = viewModel.numberToGuess else { return }
        let maxNumberOfGuesses = viewModel.maxNumberOfGuesses
        
        for _ in 1...maxNumberOfGuesses {
            viewModel.validateGuess(guess - 1)
        }
        
        XCTAssertTrue(viewModel.isGameOver)
        XCTAssertTrue(delegateMock.showExceededAttemptsAlertCalled)
    }
    
    func testValidateGuessGreaterThanNumber() {
        viewModel.generateRandomNumber()
        
        viewModel.validateGuess(9)
        
        XCTAssertTrue(delegateMock.showGreaterThanNumberAlertCalled)
        XCTAssertEqual(viewModel.currentGuesses, 1)
        XCTAssertFalse(viewModel.isGameOver)
    }
    
    func testValidateGuessLessThanNumber() {
        viewModel.generateRandomNumber()
        
        viewModel.validateGuess(4)
        
        XCTAssertTrue(delegateMock.showLessThanNumberAlertCalled)
        XCTAssertEqual(viewModel.currentGuesses, 1)
        XCTAssertFalse(viewModel.isGameOver)
    }
    
    func testValidateGuessOutOfBoundsLower() {
        viewModel.generateRandomNumber()
        viewModel.validateGuess(-5)
        
        XCTAssertTrue(delegateMock.showBoundsAlertsCalled)
        XCTAssertEqual(viewModel.currentGuesses, 1)
        XCTAssertFalse(viewModel.isGameOver)
    }
    
    func testValidateGuessOutOfBoundsUpper() {
        viewModel.generateRandomNumber()
        viewModel.validateGuess(15)

        XCTAssertTrue(delegateMock.showBoundsAlertsCalled)
        XCTAssertEqual(viewModel.currentGuesses, 1)
        XCTAssertFalse(viewModel.isGameOver)
    }
}
