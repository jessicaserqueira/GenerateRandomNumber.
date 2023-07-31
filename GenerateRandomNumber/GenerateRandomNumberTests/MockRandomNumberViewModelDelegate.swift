//
//  RandomNumberViewModelDelegateMock.swift
//  GenerateRandomNumberTests
//
//  Created by Jessica Serqueira on 24/07/23.
//

import XCTest
@testable import GenerateRandomNumber

class MockRandomNumberViewModelDelegate: RandomNumberViewModelDelegate {
    var numberGeneratedCalled = false
    var showLessThanNumberAlertCalled = false
    var showGreaterThanNumberAlertCalled = false
    var showWinAlertsCalled = false
    var showBoundsAlertsCalled = false
    var showExceededAttemptsAlertCalled = false
    var generatedNumber: Int = 0
    var attempts: Int = 0

    func numberGenerated(_ number: Int) {
        numberGeneratedCalled = true
        generatedNumber = number
    }

    func showLessThanNumberAlert() {
        showLessThanNumberAlertCalled = true
    }

    func showGreaterThanNumberAlert() {
        showGreaterThanNumberAlertCalled = true
    }

    func showWinAlerts(with attempts: Int) {
        showWinAlertsCalled = true
        self.attempts = attempts
    }

    func showBoundsAlerts() {
        showBoundsAlertsCalled = true
    }

    func showExceededAttemptsAlert() {
        showExceededAttemptsAlertCalled = true
    }
}
