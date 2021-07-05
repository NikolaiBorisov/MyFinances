//
//  MFImageView.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 29.06.2021.
//

import UIKit

class MFImageView: UIImageView {
  
  init() {
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.contentMode = .scaleAspectFill
    self.image = Constants.Image.defaultAvatar
    self.layer.cornerRadius = 75
    self.layer.borderWidth = 3
    self.layer.borderColor = UIColor.customGreen.cgColor
    self.layer.masksToBounds = true
    self.isUserInteractionEnabled = true
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
}
