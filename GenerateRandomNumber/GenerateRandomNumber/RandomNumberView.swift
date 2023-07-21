//
//  RandomNumberView.swift
//  GenerateRandomNumber
//
//  Created by Jessica Serqueira on 17/07/23.
//

import UIKit

protocol RandomViewDelegate: AnyObject {
    func didTapRandomButton(_ guess: Int)
}

class RandomNumberView: UIView {
    weak var delegate: RandomViewDelegate?
    
    var randomNumber = 0
    
    //MARK: - Views
    private var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 135/255, green: 206/255, blue: 250/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "RandomNumberView.mainView"
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tente acertar o número"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "RandomNumberView.titleLabel"
        
        return label
    }()
    
    private var numberField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Escolha seu número",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = "RandomNumberView.randomNumberTextField"
        
        return textField
    }()
    
    private var randomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1.0)
        button.setTitle("Tente a sorte", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "RandomNumberView.randomButton"
        
        return button
    }()
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubviews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateNumber(with number: Int) {
        randomNumber = number
    }
    
    private func setupActions() {
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
    }
    
    @objc private func randomButtonTapped() {
        if let guess = numberField.text, let guessInt = Int(guess) {
            randomNumber += 1
            delegate?.didTapRandomButton(guessInt)
        }
    }
    
    //MARK: - Subviews
    
    func configureSubviews() {
        addSubview(mainView)
        
        mainView.addSubview(titleLabel)
        mainView.addSubview(numberField)
        mainView.addSubview(randomButton)
    }
    
    //MARK: - Constraints
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 200),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            numberField.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberField.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberField.widthAnchor.constraint(equalToConstant: 200),
            numberField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            randomButton.topAnchor.constraint(equalTo: numberField.bottomAnchor, constant: 30),
            randomButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            randomButton.widthAnchor.constraint(equalToConstant: 200),
            randomButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func didTapRandomButton(_ guess: Int) {
        delegate?.didTapRandomButton(guess)
    }
}
