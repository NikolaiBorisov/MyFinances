//
//  TotalBallanceViewController.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 25.06.2021.
//

import UIKit
import Charts
import Firebase
import FirebaseStorage

class TotalBallanceViewController: UIViewController, AddCostViewDelegate, ChartViewDelegate {
  
  lazy var viewMaker = HomeView(container: self)
  var costs: [Cost] = []
  var incomes = PieChartDataEntry(value: 0)
  var outcomes = PieChartDataEntry(value: 0)
  var numberOfDataEntries = [PieChartDataEntry]()
  let db = Firestore.firestore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewMaker.setupLayouts()
    self.view.backgroundColor = .tertiarySystemGroupedBackground
    navigationItem.title = "Balance"
    viewMaker.view.delegate = self
    setupTableView()
    setChart()
    updateChart()
    viewMaker.addButton.addTarget(self, action: #selector(toAddScreen), for: .touchUpInside)
    fetchBallanceInfo()
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      updateChart()
  }
  
  private func fetchBallanceInfo() {
      
      guard let userId = Auth.auth().currentUser?.uid else { return }
      Firestore.firestore().collection("users").document(userId).getDocument { [weak self] (document, error) in
          if let document = document, document.exists {
              let data = document.data()
              if let expences: [String: Any] = data?["tasks"] as? [String: Any] {
                  expences.keys.forEach {
                      let value = ((expences[$0] as? [String: Any])?["cost"]) as? String
                      let image = ((expences[$0] as? [String: Any])?["image"]) as? String
                      self?.costs.append(.init(name: $0, cost: value, image: UIImage(named: image ?? "")))
                      if image == "income" {
                          DispatchQueue.main.async {
                              self?.incomes.value += Double(value ?? "") ?? 0
                              self?.updateChart()
                          }
                      } else {
                          DispatchQueue.main.async {
                              self?.outcomes.value += Double(value ?? "") ?? 0
                              self?.updateChart()
                          }
                      }
                  }
              }
          }
          print("Data successfully fetched")
          DispatchQueue.main.async {
              self?.viewMaker.tableView.reloadData()
          }
      }
  }
  
  private func setupTableView() {
    let nib = UINib(nibName: "BalanceTableViewCell", bundle: nil)
    viewMaker.tableView.register(nib, forCellReuseIdentifier: BalanceTableViewCell.identifier)
    viewMaker.tableView.delegate = self
    viewMaker.tableView.dataSource = self
  }
  
  private func setChart() {
    incomes.label = "Income"
    outcomes.label = "Expences"
    
    numberOfDataEntries = [outcomes, incomes]
  }
  
  private func updateChart() {
    let chartDataSet = PieChartDataSet(entries: numberOfDataEntries,label: nil)
    let chartData = PieChartData(dataSet: chartDataSet)
    let colors = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)]
    chartDataSet.colors = colors
    viewMaker.view.data = chartData
    viewMaker.view.centerText = "% Income & Expences"
  }
  
  @objc private func toAddScreen() {
    let vc = AddCostsViewController()
    vc.delegate = self
    vc.modalPresentationStyle = .popover
    self.present(vc, animated: true, completion: nil)
  }
  
  func addItems(_ cost: Cost, type: Int) {
    costs.append(cost)
    if type == 0 {
      outcomes.value += Double(cost.cost ?? "") ?? 0
      updateChart()
    } else {
      incomes.value += Double(cost.cost ?? "") ?? 0
      updateChart()
    }
    viewMaker.tableView.reloadData()
  }
  
}

extension TotalBallanceViewController: UITableViewDelegate,UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return costs.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: BalanceTableViewCell.identifier, for: indexPath) as? BalanceTableViewCell
    else { fatalError("Could not dequeue cell") }
    if indexPath.row >= 0 {
      let cost = costs[indexPath.row]
      cell.costLabel.text = (cost.cost!) + " ₽"
      cell.nameLabel.text = cost.name
      cell.iconImage.image = cost.image
      return cell
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
    view.tintColor = UIColor.clear
    guard let header = view as? UITableViewHeaderFooterView else { return }
    header.textLabel?.textColor = UIColor.black
    header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    header.textLabel?.frame = header.frame
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10.0))
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 10, height: 30.0))
    label.font = .avenirNextMedium20
    view.backgroundColor = UIColor.customGreen.withAlphaComponent(0.1)
    label.text = "Income & Expences"
    label.textAlignment = .center
    label.textColor = .customGreen
    view.addSubview(label)
    view.layer.cornerRadius = 14
    view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    view.layer.masksToBounds = true
    return view
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    return 30
  }
  
}
