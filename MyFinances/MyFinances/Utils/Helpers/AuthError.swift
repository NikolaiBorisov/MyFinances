//
//  AuthError.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 30.06.2021.
//

import Foundation

enum AuthError {
  case notFilled
  case invalidEmail
  case invalidPassword
  case unknownError
  case serverError
  case avatarHasNotBeenSet
}

extension AuthError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .notFilled:
      return NSLocalizedString("Please, fill all the fields", comment: "")
    case .invalidEmail:
      return NSLocalizedString("Email is not valid", comment: "")
    case .invalidPassword:
      return NSLocalizedString("Password is not valid!\nRequirements:\nMinimum 6 characters\nAt least 1 Alphabet\nAt least 1 Number\nOnly Latin letters:", comment: "")
    case .unknownError:
      return NSLocalizedString("Server error", comment: "")
    case .serverError:
      return NSLocalizedString("Server error", comment: "")
    case .avatarHasNotBeenSet:
      return NSLocalizedString("User didn't choose the avatar", comment: "")
    }
  }
}
