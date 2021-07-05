//
//  FirebaseManager.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 25.06.2021.
//

import Foundation
import Firebase

class FirebaseManager {
  
  func signInWithFirebase(email: String, password: String, errorCallBack: @escaping ((Error) -> Void), pushCallBack: @escaping (() -> Void)) {
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      if let error = error {
        errorCallBack(error) // self?.showSignInAlert(errorMessage: error.localizedDescription)
        print(error.localizedDescription)
      } else {
        guard let uid = result?.user.uid else { return }
        print("User: \(uid) signed in")
        pushCallBack()
        //self?.defaults.setValue(true, forKey: "UserIsLoggedIn")
        //let vc = HomeViewController()
        //self?.navigationController?.pushViewController(vc, animated: true)
      }
    }
  }
  
}
