//
//  AddIncomeAndExpencesViewController.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 28.06.2021.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

final class AddIncomeAndExpencesViewController: UIViewController {
  
  lazy var viewMaker = AddCostView(container: self)
  weak var incomeDelegate: AddIncomeDelegate?
  weak var expenceDelegate: AddExpencesDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    setupHideKeyboardOnTaps()
    viewMaker.setupLayouts()
    addTargets()
    setConfirmButton(enabled: false)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillAppear),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
  }
  
  private func addTargets() {
    viewMaker.categoryTitleTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    viewMaker.categoryAmountTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    viewMaker.saveButton.addTarget(self, action: #selector(confirmAddAction), for: .touchUpInside)
  }
  
  @objc private func textFieldChanged() {
    guard
      let name = viewMaker.categoryTitleTextField.text,
      let cost = viewMaker.categoryAmountTextField.text
    else { return }
    let formFilled = !(name.isEmpty) && !(cost.isEmpty)
    setConfirmButton(enabled: formFilled)
  }
  
  private func setConfirmButton(enabled: Bool) {
    if enabled {
      viewMaker.saveButton.alpha = 1.0
      viewMaker.saveButton.isEnabled = true
    } else {
      viewMaker.saveButton.alpha = 0.5
      viewMaker.saveButton.isEnabled = false
    }
  }
  
  @objc private func confirmAddAction() {
    guard
      let name = viewMaker.categoryTitleTextField.text, !name.isEmpty,
      let cost = viewMaker.categoryAmountTextField.text, !cost.isEmpty
    else { return }
    let item = IncomeAndExpences(type: name, amount: cost)
    self.incomeDelegate?.addIncome(item: item)
    self.expenceDelegate?.addExpence(item: item)
    saveEnteredDataToFB()
    self.dismiss(animated: true, completion: nil)
  }
  
  private func saveEnteredDataToFB() {
    guard let userId = Auth.auth().currentUser?.uid else { return }
    let titleTf = viewMaker.categoryTitleTextField.text
    let amountTf = viewMaker.categoryAmountTextField.text
    let db = Firestore.firestore()
    var dictionary: [String: Any] = [:]
    if incomeDelegate != nil {
      dictionary["income"] = [
        titleTf: [
          "amount": amountTf ?? "none"
        ]
      ]
    } else if expenceDelegate != nil {
      dictionary["expences"] = [
        titleTf: [
          "amount": amountTf ?? "none"
        ]
      ]
    }
    db.collection("users").document(userId).setData(dictionary, merge: true)
  }
  
  
  @objc func keyboardWillAppear(notification: NSNotification) {
    let userInfo = notification.userInfo!
    let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    viewMaker.saveButton.center = CGPoint(
      x: view.center.x,
      y: view.frame.height - keyboardFrame.height - 16.0 - viewMaker.saveButton.frame.height / 2
    )
    viewMaker.cardView.center = CGPoint(
      x: view.center.x,
      y: view.frame.height - keyboardFrame.height - 86.0 - viewMaker.cardView.frame.height / 2
    )
  }
  
}
