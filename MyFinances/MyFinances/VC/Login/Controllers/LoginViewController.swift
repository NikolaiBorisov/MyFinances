//
//  LoginViewController.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 24.06.2021.
//

import UIKit
import Firebase

protocol LogInOutput: AnyObject {
  func didFinishAuthorization()
}

final class LoginViewController: UIViewController {
  
  private lazy var viewMaker = LoginViewMaker(container: self)
  var delegate: LogInOutput?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupHideKeyboardOnTaps()
    viewMaker.setupLayouts()
    setupActionForButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  private func setupActionForButton() {
    viewMaker.forgotPasswordButton.addTarget(self, action: #selector(onForgotButtonTapped(_:)), for: .touchUpInside)
    viewMaker.signInButton.addTarget(self, action: #selector(onSignInButtonTapped(_:)), for: .touchUpInside)
    viewMaker.createAccountButton.addTarget(self, action: #selector(onCreateButtonTapped(_:)), for: .touchUpInside)
  }
  
  @objc private func onSignInButtonTapped(_ sender: UIButton) {
    guard let email = viewMaker.emailTextField.text,
          let password = viewMaker.passwordTextField.text
    else { return }
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
      if let error = error {
        self?.showAlert(with: "Error occured", and: error.localizedDescription)
        print(error.localizedDescription)
      } else {
        guard let uid = result?.user.uid else { return }
        print("User: \(uid) signed in")
        UserDefaults.standard.isLoggedIn = true
        self?.delegate?.didFinishAuthorization()
      }
    }
  }
  
  @objc private func onForgotButtonTapped(_ sender: UIButton) {
    // TODO: logic for forgotten password will be here
    //showForgottenPasswordAlert()
    let vc = ResetPasswordViewController()
    vc.modalTransitionStyle = .flipHorizontal
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc private func onCreateButtonTapped(_ sender: UIButton) {
    let vc = SignUpViewController()
    vc.delegate = self.delegate
    navigationController?.pushViewController(vc, animated: true)
  }

}

// MARK: - TextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}
