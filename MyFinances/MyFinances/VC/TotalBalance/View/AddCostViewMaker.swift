//
//  AddCostViewTotalBallance.swift
//  MyFinances
//
//  Created by galiev nail on 28.06.2021.
//

import UIKit
import SnapKit

final class AddCostViewMaker {
  
  unowned var container: AddCostsViewController
  
  init(container: AddCostsViewController) {
    self.container = container
  }
  
  lazy var cartView: UIView = {
    let view = UIView()
    view.backgroundColor = .customGreen
    view.layer.cornerRadius = 14
    view.addSubview(nameTextField)
    view.addSubview(costTextField)
    view.addSubview(segmentControl)
    return view
  }()
  
  lazy var nameTextField: UITextField = {
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
  
  lazy var label: UILabel = {
    var label = UILabel()
    label.text = "Add new Category"
    label.textAlignment = .center
    label.font = .avenirNextMedium30
    label.textColor = .customGreen
    return label
  }()
  
  lazy var continueButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .customGreen
    button.setTitle("Save", for: .normal)
    button.titleLabel?.font = .avenirNextMedium30
    button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    button.layer.cornerRadius = 14
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.lightGray.cgColor
    return button
  }()
  
  lazy var segmentControl: UISegmentedControl = {
    let items = ["Expence","Income"]
    var segment = UISegmentedControl(items: items)
    segment.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    let titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    segment.setTitleTextAttributes(titleTextAttributes, for: .application)
    segment.selectedSegmentIndex = 0
    return segment
  }()
  
  lazy var costTextField: UITextField = {
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
    container.view.addSubview(cartView)
    container.view.addSubview(continueButton)
    container.view.addSubview(label)
    
    label.snp.makeConstraints { make in
      make.bottom.equalTo(cartView.snp.top).offset(-50)
      make.centerX.equalToSuperview()
    }
    
    cartView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(130)
      make.centerX.equalToSuperview()
      make.left.equalToSuperview().offset(20)
      make.height.equalTo(200)
    }
    
    //        label.snp.makeConstraints { make in
    //            make.bottom.equalTo(cartView.snp.top).offset(60)
    //            make.width.equalTo(100)
    //        }
    
    nameTextField.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.height.equalTo(30)
      make.left.equalToSuperview().inset(70)
      make.right.equalToSuperview().inset(30)
    }
    
    costTextField.snp.makeConstraints { make in
      make.top.equalTo(nameTextField.snp.bottom).offset(20)
      make.height.equalTo(30)
      make.leftMargin.equalTo(nameTextField).inset(50)
      make.rightMargin.equalTo(nameTextField)
    }
    
    continueButton.snp.makeConstraints { make in
      make.left.equalToSuperview().inset(20)
      make.right.equalToSuperview().inset(20)
      make.height.equalTo(56)
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().inset(70)
    }
    
    segmentControl.snp.makeConstraints { make in
      make.leftMargin.height.width.equalTo(nameTextField)
      make.top.equalTo(costTextField.snp.bottom).offset(30)
    }
  }
}
