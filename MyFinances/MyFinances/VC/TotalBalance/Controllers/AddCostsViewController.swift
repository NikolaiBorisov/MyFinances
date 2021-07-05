//
//  AddCostsViewController.swift
//  MyFinances
//
//  Created by galiev nail on 28.06.2021.
//

import UIKit
import Firebase

protocol AddCostViewDelegate: AnyObject {
  func  addItems(_ cost: Cost, type: Int)
}

class AddCostsViewController: UIViewController {
  
  let db = Firestore.firestore()
  
  lazy var viewMaker = AddCostViewMaker(container: self)
  
  weak var delegate: AddCostViewDelegate?
  
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
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillAppear),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
  }
  
  
  private func addTargets() {
    viewMaker.nameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    viewMaker.costTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    viewMaker.continueButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
  }
  
  @objc private func textFieldChanged() {
    
    guard
      let name = viewMaker.nameTextField.text,
      let cost = viewMaker.costTextField.text
    else { return }
    
    let formFilled = !(name.isEmpty) && !(cost.isEmpty)
    
    setConfirmButton(enabled: formFilled)
  }
  
  private func setConfirmButton(enabled: Bool) {
    
    if enabled {
      viewMaker.continueButton.alpha = 1.0
      viewMaker.continueButton.isEnabled = true
    } else {
      viewMaker.continueButton.alpha = 0.5
      viewMaker.continueButton.isEnabled = false
    }
  }
  
  @objc private func confirm() {
    let nameTF = viewMaker.nameTextField.text ?? ""
    let costTF = viewMaker.costTextField.text ?? ""
    switch viewMaker.segmentControl.selectedSegmentIndex {
    case 0:
        let cost = Cost(name: nameTF, cost: costTF, image: UIImage(named: "outcome")!)
        delegate?.addItems(cost, type: 0)
        let docData: [String: Any] = [ "tasks": [
            nameTF: [
                "name": nameTF,
                "image": "outcome",
                "cost": costTF
            ]
          ]
        ]
        
        db.collection("users").document(Auth.auth().currentUser!.uid).setData(docData, merge: true)
    case 1:
        let cost = Cost(name: nameTF, cost: costTF, image: UIImage(named: "income")!)
        delegate?.addItems(cost, type: 1)
        let docData: [String: Any] = [ "tasks": [
            nameTF: [
                "name": nameTF,
                "image": "income",
                "cost": costTF
            ]
          ]
        ]
        db.collection("users").document(Auth.auth().currentUser!.uid).setData(docData, merge: true)

    default:
        break
    }
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func keyboardWillAppear(notification: NSNotification) {
    let userInfo = notification.userInfo!
    let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    viewMaker.continueButton.center =
      CGPoint(x: view.center.x,
              y: view.frame.height - keyboardFrame.height - 16.0 - viewMaker.continueButton.frame.height / 2)
  }
}
