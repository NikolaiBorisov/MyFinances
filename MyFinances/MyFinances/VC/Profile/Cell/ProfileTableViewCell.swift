//
//  ProfileTableViewCell.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 27.06.2021.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {
  
  lazy var incomeTypeLabel: UILabel = {
    let label = MFLabel(type: .none, fontSize: 17.0)
    label.textColor = .label
    label.font = .avenirNextMedium17
    return label
  }()
  
  lazy var incomeSumLabel: UILabel = {
    let label = MFLabel(type: .none, fontSize: 17.0)
    label.textColor = .label
    return label
  }()
  
//  var ballance: IncomeAndExpences? {
//    didSet {
//      print("Ballance has been set")
//      guard let title = ballance?.type,
//            let amount = ballance?.amount
//      else { return }
//      incomeTypeLabel.text = title
//      incomeSumLabel.text = amount
//    }
//  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
  private func setupLayouts() {
    [
      incomeTypeLabel,
      incomeSumLabel
    ]
    .forEach {
      contentView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      
      incomeTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
      incomeTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
      incomeTypeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      incomeSumLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
      incomeSumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      incomeSumLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
      
    ])
  }
  
  func configure(with model: IncomeAndExpences, isExpences: Bool) {
    incomeTypeLabel.text = model.type
    incomeSumLabel.text = ("\(model.amount) ₽")
    self.incomeSumLabel.textColor = isExpences ? .red : .customGreen
  }
  
}
