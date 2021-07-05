//
//  ProfileViewMaker.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 27.06.2021.
//

import UIKit

final class ProfileViewMaker {
  
  unowned var container: ProfileViewController
  
  init(container: ProfileViewController) {
    self.container = container
  }
  
  lazy var userAvatar: UIImageView = {
    let image = MFImageView()
    return image
  }()
  
  lazy var dateOfBirthPlaceholderLabel: UILabel = {
    let label = MFLabel(type: .dateOfBirth, fontSize: 17.0)
    label.textAlignment = .left
    label.textColor = .lightGray
    return label
  }()
  
  lazy var dateOfBirthLabel: UILabel = {
    let label = MFLabel(type: .none, fontSize: 20.0)
    label.textColor = .label
    label.textAlignment = .left
    label.text = " "
    return label
  }()
  
  lazy var dateStackView: UIStackView = {
    let stackView = MFStackView()
    stackView.spacing = 5
    stackView.distribution = .fillProportionally
    [
      dateOfBirthPlaceholderLabel,
      dateOfBirthLabel
    ]
    .forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  
  lazy var occupationPlaceholderLabel: UILabel = {
    let label = MFLabel(type: .occupation, fontSize: 17.0)
    label.textAlignment = .left
    label.textColor = .lightGray
    return label
  }()
  
  lazy var occupationLabel: UILabel = {
    let label = MFLabel(type: .none, fontSize: 20.0)
    label.textColor = .label
    label.textAlignment = .left
    label.text = " "
    return label
  }()
  
  lazy var occupationStackView: UIStackView = {
    let stackView = MFStackView()
    stackView.spacing = 5
    stackView.distribution = .fillProportionally
    [
      occupationPlaceholderLabel,
      occupationLabel
    ]
    .forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  
  lazy var notificationLabel: UILabel = {
    let label = MFLabel(type: .notification, fontSize: 17.0)
    label.textColor = .lightGray
    label.textAlignment = .left
    return label
  }()
  
  lazy var switcher: UISwitch = {
    let switcher = UISwitch()
    return switcher
  }()

  lazy var notificationStackView: UIStackView = {
    let stackView = MFStackView()
    stackView.axis = .horizontal
    stackView.spacing = 1
    stackView.distribution = .equalCentering
    [
      notificationLabel,
      switcher
    ]
    .forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  
  lazy var incomeButton: UIButton = {
    let button = MFButton(type: .addIncome)
    button.backgroundColor = .customGreen
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.avenirNextMedium17
    return button
  }()
  
  lazy var expencesButton: UIButton = {
    let button = MFButton(type: .addExpences)
    button.backgroundColor = .customGreen
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.avenirNextMedium17
    return button
  }()
  
  lazy var buttonStackView: UIStackView = {
    let stackView = MFStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    [
      incomeButton,
      expencesButton
    ]
    .forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  
  lazy var maintackView: UIStackView = {
    let stackView = MFStackView()
    stackView.distribution = .fillProportionally
    [
      dateStackView,
      occupationStackView
    ]
    .forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  
  lazy var profileTableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.layer.cornerRadius = 14
    return tableView
  }()
  
  func setupLayouts() {
    [
      userAvatar,
      maintackView,
      notificationStackView,
      buttonStackView,
      profileTableView
    ]
    .forEach { container.view.addSubview($0) }
    
    NSLayoutConstraint.activate([
     
      userAvatar.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      userAvatar.topAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
      userAvatar.heightAnchor.constraint(equalToConstant: 150.0),
      userAvatar.widthAnchor.constraint(equalToConstant: 150.0),
      
      maintackView.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      maintackView.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 20.0),
      maintackView.leadingAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
      
      notificationStackView.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      notificationStackView.topAnchor.constraint(equalTo: maintackView.bottomAnchor, constant: 10.0),
      notificationStackView.leadingAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
      
      buttonStackView.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      buttonStackView.topAnchor.constraint(equalTo: notificationStackView.bottomAnchor, constant: 10.0),
      buttonStackView.leadingAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
      
      profileTableView.centerXAnchor.constraint(equalTo: container.view.centerXAnchor),
      profileTableView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 10.0),
      profileTableView.leadingAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
      profileTableView.bottomAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.bottomAnchor)
      
    ])
  }
  
}
