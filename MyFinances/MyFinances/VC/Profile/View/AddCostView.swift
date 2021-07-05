//
//  AddCostView.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 28.06.2021.
//

import UIKit
import SnapKit

final class AddCostView {
  
  unowned var container: AddIncomeAndExpencesViewController
  
  init(container: AddIncomeAndExpencesViewController) {
    self.container = container
  }
  
  lazy var label: UILabel = {
    var label = UILabel()
    label.text = "Add new Category"
    label.textAlignment = .center
    label.font = .avenirNextMedium30
    label.textColor = .customGreen
    return label
  }()
  
  lazy var cardView: UIView = {
    let view = UIView()
    view.backgroundColor = .customGreen
    view.layer.cornerRadius = 15
    view.layer.borderWidth = 2
    view.layer.borderColor = UIColor.lightGray.cgColor
    [
      categoryTitleTextField,
      categoryAmountTextField
    ]
    .forEach { view.addSubview($0) }
    return view
  }()
  
  lazy var categoryTitleTextField: UITextField = {
    var textF = UITextField()
    textF.attributedPlaceholder = NSAttributedString(string: "Enter the Title",
                                                     attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
    let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    textF.leftViewMode = UITextField.ViewMode.always
    textF.leftView = spacerView
    textF.textColor = .white
    textF.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    textF.font = .avenirNextMedium20
    return textF
  }()
  
  lazy var saveButton: UIButton = {
    let button = MFButton(type: .save)
    button.backgroundColor = .customGreen
    return button
  }()
  
  lazy var categoryAmountTextField: UITextField = {
    var textF = UITextField()
    textF.attributedPlaceholder = NSAttributedString(string: "0",
                                                     attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
    let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    textF.leftViewMode = UITextField.ViewMode.always
    textF.leftView = spacerView
    textF.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    textF.textColor = .white
    textF.font = .avenirNextMedium20
    return textF
  }()
  
  func setupLayouts() {
    [
      label,
      cardView,
      saveButton
    ]
    .forEach { container.view.addSubview($0) }
    
    label.snp.makeConstraints { make in
      make.bottom.equalTo(cardView.snp.top).offset(-50)
      make.centerX.equalToSuperview()
    }
    
    cardView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(130)
      make.centerX.equalToSuperview()
      make.left.equalToSuperview().offset(20)
      make.height.equalTo(200)
    }
    
    categoryTitleTextField.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.height.equalTo(30)
      make.left.equalToSuperview().inset(70)
      make.right.equalToSuperview().inset(30)
    }
    
    categoryAmountTextField.snp.makeConstraints { make in
      make.top.equalTo(categoryTitleTextField.snp.bottom).offset(20)
      make.height.equalTo(30)
      make.leftMargin.equalTo(categoryTitleTextField).inset(50)
      make.rightMargin.equalTo(categoryTitleTextField)
    }
    
    saveButton.snp.makeConstraints { make in
      make.left.equalToSuperview().inset(20)
      make.right.equalToSuperview().inset(20)
      make.height.equalTo(56)
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().inset(70)
    }
  }
  
}
