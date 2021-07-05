//
//  ResetPasswordViewController.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 05.07.2021.
//

import UIKit
// added new framework
import ProgressHUD

class ResetPasswordViewController: UIViewController {
  
  private lazy var viewMaker = ResetViewMaker(container: self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    viewMaker.setupLayouts()
    viewMaker.resetButton.addTarget(self, action: #selector(onResetButtonTapped(_:)), for: .touchUpInside)
  }
  
  @objc private func onResetButtonTapped(_ sender: UIButton) {
    guard let email = viewMaker.resetPasswordTF.text,
          email != ""
    else {
      ProgressHUD.showError(Constants.Error.emailResetError)
      return
    }
    UserApi.resetPassword(email: email, onSuccess: {
      self.view.endEditing(true)
      ProgressHUD.showSuccess(Constants.Error.resetSuccessMessage)
      self.navigationController?.popViewController(animated: true)
    }) { (errorMessage) in
      ProgressHUD.showError(errorMessage)
    }
  }
  
}
