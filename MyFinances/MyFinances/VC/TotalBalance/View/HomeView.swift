//
//  HomeView.swift
//  MyFinances
//
//  Created by galiev nail on 26.06.2021.
//

import UIKit
import Charts

final class HomeView {
  
  unowned var container: TotalBallanceViewController
  
  init(container: TotalBallanceViewController) {
    self.container = container
  }
  
  lazy var view: PieChartView = {
    let view = PieChartView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 14
    view.clipsToBounds = true
    return view
  }()
  
  lazy var addButton: UIButton = {
    let button = UIButton()
    button.setTitle("Add new Category", for: .normal)
    button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    button.backgroundColor = .customGreen
    button.layer.cornerRadius = 14.0
    button.titleLabel?.font = .avenirNextMedium17
    button.layer.borderWidth = 2.0
    button.layer.borderColor = UIColor.lightGray.cgColor
    return button
    
  }()
  
  lazy var tableView: UITableView = {
    var tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: BalanceTableViewCell.identifier)
    tableView.layer.cornerRadius = 14
    return tableView
  }()
  
  func setupLayouts() {
    container.view.addSubview(view)
    container.view.addSubview(tableView)
    container.view.addSubview(addButton)
    
    view.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(90)
      make.left.right.equalToSuperview().inset(20)
      make.height.equalTo(350)
    }
    
    addButton.snp.makeConstraints { make in
      make.top.equalTo(view.snp.bottom)
      make.right.equalToSuperview().inset(20)
      make.width.equalTo(180)
    }
    
    tableView.snp.makeConstraints { make in
      make.top.equalTo(addButton.snp.bottom)
      make.left.right.equalToSuperview().inset(20)
      make.bottom.equalToSuperview().inset(-15)
    }
  }
}
