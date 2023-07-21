//
//  ViewController.swift
//  GenerateRandomNumber
//
//  Created by Jessica Serqueira on 17/07/23.
//

import UIKit

class RandomNumberViewController: UIViewController {
    
    private var customView = RandomNumberView()
    private var viewModel:  RandomNumberViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.generateRandomNumber()
    }
    
    //MARK: - Initializer
    
    init(viewModel: RandomNumberViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        self.view = customView
        customView.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
}

extension RandomNumberViewController: RandomViewDelegate {
    func didTapRandomButton(_ guess: Int) {
        viewModel.validateGuess(guess)
    }
}

extension RandomNumberViewController: RandomNumberViewModelDelegate {
    func numberGenerated(_ number: Int) {
        customView.updateNumber(with: number)
    }
    
    func showLessThanNumberAlert() {
        showAlert(title: "Oops! 😕", message: "Seu palpite está abaixo do número a ser adivinhado.")
    }
    
    func showGreaterThanNumberAlert() {
        showAlert(title: "Oops! 😕", message: "Seu palpite está acima do número a ser adivinhado.")
    }
    
    func showWinAlerts(with attempts: Int) {
        showAlert(title: "Parabéns! 🎉", message: "Você ganhou com um total de \(attempts) suposições.")
    }
    
    func showBoundsAlerts() {
        showAlert(title: "Oi!", message: "Seu palpite deve ficar entre 1 e 10!")
    }
    
    func showExceededAttemptsAlert() {
        showAlert(title: "Oops! ❌", message: "Você atingiu o número máximo de tentativas. Deseja jogar novamente?", showPlayAgain: true)
    }
    
    private func showAlert(title: String, message: String, showPlayAgain: Bool = false) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if showPlayAgain {
            let playAgainAction = UIAlertAction(title: "Jogar novamente", style: .default) { [weak self] _ in
                self?.viewModel.generateRandomNumber()
                self?.viewModel.isGameOver = false
            }
            alert.addAction(playAgainAction)
        }
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
