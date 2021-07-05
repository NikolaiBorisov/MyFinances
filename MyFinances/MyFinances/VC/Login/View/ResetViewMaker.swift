//
//  ResetViewMaker.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 05.07.2021.
//

import UIKit
import SnapKit

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
    
    resetStackView.snp.makeConstraints { make in
      make.top.equalTo(container.view.safeAreaLayoutGuide).offset(20)
      make.centerX.equalToSuperview()
      make.left.equalToSuperview().offset(20)
    }
  }
  
}
