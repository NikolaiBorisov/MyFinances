//
//  UIViewController+Ext.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 22.06.2021.
//

import UIKit

extension UIViewController {
  
  func setupHideKeyboardOnTaps() {
    self.view.addGestureRecognizer(self.endEditingRecognizer())
    self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
  }
  
  private func endEditingRecognizer() -> UIGestureRecognizer {
    return UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
  }
  
  func showAlert(with title: String, and message: String, completion: @escaping () -> Void = { }) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
      completion()
    }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
  
  // added alert for forgotten password
  func showForgottenPasswordAlert() {
    let alert = UIAlertController(
      title: "Get a new password",
      message: "Enter your email and we will send all the information you needed",
      preferredStyle: .alert
    )
    let closeAction = UIAlertAction(title: "Dismiss", style: .destructive)
    let sendAction = UIAlertAction(title: "Send", style: .default)
    let tf = alert.textFields?.first
    let text = tf?.text
    alert.addTextField()
    alert.addAction(closeAction)
    alert.addAction(sendAction)
    present(alert, animated: true, completion: nil)
  }
  
}
