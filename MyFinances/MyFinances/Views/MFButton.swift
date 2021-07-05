//
//  MFButton.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 22.06.2021.
//

import UIKit

class MFButton: UIButton {
  
  init(type: Constants.MFButtonType) {
    super.init(frame: .zero)
    self.setTitle(type.rawValue, for: .normal)
    self.layer.cornerRadius = 14.0
    self.titleLabel?.font = .avenirNextMedium30
    self.layer.borderWidth = 2.0
    self.layer.borderColor = UIColor.lightGray.cgColor
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
}
