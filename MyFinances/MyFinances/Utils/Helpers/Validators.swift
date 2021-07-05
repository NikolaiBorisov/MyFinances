//
//  Validators.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 30.06.2021.
//

import Foundation

class Validators {
  
  static func isFilled(name: String?, email: String?, dateOfBirth: String?, occupation: String?, password: String?) -> Bool {
    guard !(name ?? "").isEmpty,
          !(email ?? "").isEmpty,
          !(dateOfBirth ?? "").isEmpty,
          !(occupation ?? "").isEmpty,
          !(password ?? "").isEmpty
    else { return false }
    return true
  }
  
  static func isSimpleEmail(_ email: String) -> Bool {
    let emailRegEx = "^.+@.+\\..{2,}$"
    return check(text: email, regEx: emailRegEx)
  }
  
  static func isValidPassword(_ password: String) -> Bool {
    // Minimum 6 characters at least 1 Alphabet and 1 Number, only Latin letters:
    let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    return check(text: password, regEx: passwordRegEx)
  }
  
  private static func check(text: String, regEx: String) -> Bool {
    let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
    return predicate.evaluate(with: text)
  }
  
}
