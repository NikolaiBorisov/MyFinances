//
//  SignUpViewMaker.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 25.06.2021.
//

import UIKit
import InputMask

final class SignUpViewMaker {
  
  unowned var container: SignUpViewController
  
  init(container: SignUpViewController) {
    self.container = container
  }
  
  private let listener = MaskedTextFieldDelegate()
  
  lazy var userAvatar: UIImageView = {
    let image = MFImageView()
    return image
  }()
  
  lazy var nameTextField: UITextField = {
    let tf = MFTextField(placeholder: .fullNamePlaceholder)
    tf.delegate = container
    return tf
  }()
  
  lazy var emailTextField: UITextField = {
    let tf = MFTextField(placeholder: .emailAddressPlaceholder)
    tf.delegate = container
    return tf
  }()
  
  lazy var dateOfBirthTextField: UITextField = {
    let tf = MFTextField(placeholder: .dateOfBirth)
    tf.delegate = container
    return tf
  }()
  
  lazy var occupationTextField: UITextField = {
    let tf = MFTextField(placeholder: .occupation)
    tf.delegate = container
    return tf
  }()
  
  lazy var passwordTextField: UITextField = {
    let tf = MFTextField(placeholder: .passwordPlaceholder)
    tf.isSecureTextEntry = true
    tf.delegate = container
    return tf
  }()
  
  lazy var textFieldStackView: UIStackView = {
    let stackView = MFStackView()
    [
      nameTextField,
      emailTextField,
      dateOfBirthTextField,
      occupationTextField,
      passwordTextField]
      .forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  
  lazy var createAccountButton: UIButton = {
    let button = MFButton(type: .createAccount)
    button.backgroundColor = .customGreen
    button.setTitleColor(.white, for: .normal)
    return button
  }()
  
  lazy var alreadyHaveAnAccountLabel: UILabel = {
    let label = MFLabel(type: .alreadyHaveAnAccount, fontSize: 17.0)
    label.textColor = .darkGray
    label.numberOfLines = 1
    return label
  }()
  
  lazy var signInButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .white
    button.titleLabel?.font = UIFont.avenirNextMedium17
    button.setTitle(Constants.MFButtonType.signIn.rawValue, for: .normal)
    button.setTitleColor(.customGreen, for: .normal)
    return button
  }()
  
  lazy var bottomStackView: UIStackView = {
    let stackView = MFStackView()
    stackView.distribution = .fillProportionally
    [
      createAccountButton,
      alreadyHaveAnAccountLabel,
      signInButton
    ]
    .forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  
  func setupMaskForDateTextField() {
    self.listener.affinityCalculationStrategy = .prefix
    self.listener.affineFormats = [Constants.TextFieldMask.dateFormat]
    self.dateOfBirthTextField.delegate = self.listener
  }
  
  func setupLayouts() {
    [
      userAvatar,
      textFieldStackView,
      bottomStackView
    ]
    .forEach{ container.view.addSubview($0) }
    
    NSLayoutConstraint.activate([
      
      userAvatar.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      userAvatar.topAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
      userAvatar.heightAnchor.constraint(equalToConstant: 150.0),
      userAvatar.widthAnchor.constraint(equalToConstant: 150.0),
      
      textFieldStackView.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      textFieldStackView.centerYAnchor.constraint(equalTo: container.view.centerYAnchor),
      textFieldStackView.leadingAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
      textFieldStackView.heightAnchor.constraint(equalToConstant: 310.0),
      
      bottomStackView.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      bottomStackView.leadingAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
      bottomStackView.bottomAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
      
    ])
  }
  
}
