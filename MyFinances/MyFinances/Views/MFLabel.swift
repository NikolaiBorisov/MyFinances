//
//  MFLabel.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 22.06.2021.
//

import UIKit

class MFLabel: UILabel {
  
  init(type: Constants.MFLabelType, fontSize: CGFloat) {
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.textAlignment = .center
    self.text = type.rawValue
    self.font = UIFont(name: Constants.FontName.avenirNextMedium, size: fontSize)
    self.numberOfLines = 0
    self.textColor = .customGreen
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
}
