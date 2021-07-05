//
//  ResetViewMaker.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 05.07.2021.
//

import UIKit

// added ResetViewMaker
class ResetViewMaker {
  
  unowned var container: ResetPasswordViewController
  
  init(container: ResetPasswordViewController) {
    self.container = container
  }
  
  lazy var resetPasswordTF: UITextField = {
    let tf = MFTextField(placeholder: .resetPassword)
    return tf
  }()
  
  lazy var resetButton:  UIButton = {
    let button = MFButton(type: .resetPassword)
    button.backgroundColor = .customGreen
    button.setTitleColor(.white, for: .normal)
    return button
  }()
  
  lazy var resetStackView: UIStackView = {
    let stackView = MFStackView()
    [
      resetPasswordTF,
      resetButton
    ]
      .forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  
  func setupLayouts() {
    container.view.addSubview(resetStackView)
    
    NSLayoutConstraint.activate([
      
      resetStackView.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      resetStackView.topAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
      resetStackView.leadingAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0)
      
    ])
  }
  
}
