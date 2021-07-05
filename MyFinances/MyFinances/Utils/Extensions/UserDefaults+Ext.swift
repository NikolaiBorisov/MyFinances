//
//  UserDefaults+Ext.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 28.06.2021.
//

import Foundation

extension UserDefaults {
  
  enum Keys: String {
    case UserIsLoggedIn
  }
  
  var isLoggedIn: Bool {
    get { return UserDefaults.standard.bool(forKey: Keys.UserIsLoggedIn.rawValue) }
    set { UserDefaults.standard.setValue(newValue, forKey: Keys.UserIsLoggedIn.rawValue) }
  }
}
