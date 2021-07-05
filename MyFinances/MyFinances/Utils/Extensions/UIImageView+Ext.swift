//
//  UIImageView+Ext.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 27.06.2021.
//

import UIKit

extension UIImageView {
  
  func makeRoundImage() {
    self.layer.cornerRadius = self.frame.size.height / 2
    self.clipsToBounds = true
  }
  
}
