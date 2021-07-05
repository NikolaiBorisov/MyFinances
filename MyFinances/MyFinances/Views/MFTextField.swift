//
//  MFTextField.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 22.06.2021.
//

import UIKit

class MFTextField: UITextField, UITextFieldDelegate {
  
  init(placeholder: Constants.MFTextFieldType) {
    super.init(frame: .zero)
    self.delegate = self
    self.clipsToBounds = true
    self.layer.cornerRadius = 14
    self.layer.borderWidth = 2
    self.textColor = .black
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.leftViewMode = .always
    self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
    self.font = .avenirNextMedium20
    self.autocapitalizationType = .none
    self.attributedPlaceholder = NSAttributedString(
      string: placeholder.rawValue,
      attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: Constants.ColorTitle.lightGray) ?? UIColor.lightGray.cgColor]
    )
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
}
