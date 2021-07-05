//
//  UserApi.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 05.07.2021.
//

import UIKit
import Firebase

// added UserApi class
class UserApi {
  
  // added reset method
  static func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
    Auth.auth().sendPasswordReset(withEmail: email) { (error) in
      if error == nil {
        onSuccess()
      } else {
        guard let err = error else { return }
        onError(err.localizedDescription)
      }
    }
  }
  
}
