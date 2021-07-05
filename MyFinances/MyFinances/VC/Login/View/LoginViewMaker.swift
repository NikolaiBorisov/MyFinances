//
//  LoginView.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 25.06.2021.
//

import UIKit

final class LoginViewMaker {
  
  unowned var container: LoginViewController
  
  init(container: LoginViewController) {
    self.container = container
  }
  
  lazy var welcomeLabel: UILabel = {
    let label = MFLabel(type: .welcomeLabel, fontSize: 30.0)
    return label
  }()
  
  lazy var descriptionLabel: UILabel = {
    let label = MFLabel(type: .descriptionLabel, fontSize: 20.0)
    label.textColor = .darkGray
    return label
  }()
  
  lazy var topStackView: UIStackView = {
    let stackView = MFStackView()
    stackView.distribution = .fillProportionally
    [
      welcomeLabel,
      descriptionLabel
    ]
    .forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  
  lazy var emailTextField: UITextField = {
    let tf = MFTextField(placeholder: .emailAddressPlaceholder)
    tf.delegate = container
    return tf
  }()
  
  lazy var passwordTextField: UITextField = {
    let tf = MFTextField(placeholder: .passwordPlaceholder)
    tf.isSecureTextEntry = true
    tf.delegate = container
    return tf
  }()
  
  lazy var forgotPasswordButton: UIButton = {
    let button = UIButton()
    button.setTitle(Constants.MFButtonType.forgotPassword.rawValue, for: .normal)
    button.setTitleColor(.customGreen, for: .normal)
    return button
  }()
  
  lazy var middleStackView: UIStackView = {
    let stackView = MFStackView()
    [
      emailTextField,
      passwordTextField,
      forgotPasswordButton
    ]
    .forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  
  lazy var signInButton: UIButton = {
    let button = MFButton(type: .signIn)
    button.backgroundColor = .customGreen
    button.setTitleColor(.white, for: .normal)
    return button
  }()
  
  lazy var noAccountLabel: UILabel = {
    let label = MFLabel(type: .noAccount, fontSize: 17.0)
    label.textColor = .darkGray
    return label
  }()
  
  lazy var createAccountButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .white
    button.titleLabel?.font = .avenirNextMedium17
    button.setTitle(Constants.MFButtonType.createAccount.rawValue, for: .normal)
    button.setTitleColor(.customGreen, for: .normal)
    return button
  }()
  
  lazy var bottomStackView: UIStackView = {
    let stackView = MFStackView()
    stackView.distribution = .fillProportionally
    [
      signInButton,
      noAccountLabel,
      createAccountButton
    ]
    .forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  
  func setupLayouts() {
    [
      topStackView,
      middleStackView,
      bottomStackView
    ]
    .forEach{ container.view.addSubview($0) }
    
    NSLayoutConstraint.activate([
      
      topStackView.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      topStackView.topAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
      topStackView.leadingAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
      
      middleStackView.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      middleStackView.centerYAnchor.constraint(equalTo: container.view.centerYAnchor),
      middleStackView.leadingAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
      middleStackView.heightAnchor.constraint(equalToConstant: 188.0),
      
      bottomStackView.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      bottomStackView.leadingAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
      bottomStackView.bottomAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
      
    ])
  }
  
}
