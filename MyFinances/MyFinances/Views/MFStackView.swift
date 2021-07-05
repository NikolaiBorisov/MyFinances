//
//  MFStackView.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 22.06.2021.
//

import UIKit

class MFStackView: UIStackView {
  
  init() {
    super.init(frame: .zero)
    self.configureSelf()
  }
  
  required init(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
  private func configureSelf() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.axis = .vertical
    self.distribution = .fillEqually
    self.spacing = 10
  }
  
}
