//
//  PersonalAccountViewController.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 23.06.2021.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

protocol ProfileViewOutput {
  func didPressedLogOut()
}

protocol AddIncomeDelegate: AnyObject {
  func addIncome(item: IncomeAndExpences)
}

protocol AddExpencesDelegate: AnyObject {
  func addExpence(item: IncomeAndExpences)
}

class ProfileViewController: UIViewController, UINavigationControllerDelegate {
  
  private var income: [IncomeAndExpences] = []
  private var expences: [IncomeAndExpences] = []
  lazy var viewMaker = ProfileViewMaker(container: self)
  private let pickerController = UIImagePickerController()
  private let storage = Storage.storage()
  private let cell = ProfileTableViewCell()
  
  var delegate: ProfileViewOutput?
  private var usersCollection: CollectionReference!
  
  var reference = Firestore.firestore()
  
  var appUser: AppUser? {
    didSet {
      print("Value has been set")
      guard let userName = appUser?.name,
            let birthDate = appUser?.birthDate,
            let occupation = appUser?.occupation
      else { return }
      navigationItem.title = userName
      viewMaker.dateOfBirthLabel.text = birthDate
      viewMaker.occupationLabel.text = occupation
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupProfileVC()
    setupNavigationBar()
    viewMaker.setupLayouts()
    setupButtonAction()
    setupUserAvatar()
    usersCollection = Firestore.firestore().collection("users")
    fetchBallanceInfo()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewMaker.profileTableView.reloadData()
    fetchUserInfo()
    
  }
  
  private func setupUserAvatar() {
    guard let userId = Auth.auth().currentUser?.uid else { return }
    let storageRef = storage.reference(forURL: "gs://myfinances-c6468.appspot.com/avatars")
    let isLandRef = storageRef.child(userId)
    isLandRef.getData(maxSize: 1 * 1024 * 1024) { [weak self] (data, error) in
      if let error = error {
        print(error.localizedDescription)
      } else {
        let image = UIImage(data: data!)
        self?.viewMaker.userAvatar.image = image
      }
    }
  }
  
  private func setupButtonAction() {
    viewMaker.incomeButton.addTarget(self, action: #selector(onAddIncomeButtonTapped(_:)), for: .touchUpInside)
    viewMaker.expencesButton.addTarget(self, action: #selector(onAddExpencesButtonTapped(_:)), for: .touchUpInside)
    viewMaker.userAvatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAvatarTapped)))
  }
  
  @objc private func onAddIncomeButtonTapped(_ sender: UIButton) {
    let vc = AddIncomeAndExpencesViewController()
    vc.modalPresentationStyle = .popover
    vc.incomeDelegate = self
    present(vc, animated: true, completion: nil)
  }
  
  @objc private func onAddExpencesButtonTapped(_ sender: UIButton) {
    let vc = AddIncomeAndExpencesViewController()
    vc.modalPresentationStyle = .popover
    vc.expenceDelegate = self
    present(vc, animated: true, completion: nil)
  }
  
  @objc private func onAvatarTapped() {
    // TODO: here will be the logic for changing avatar
  }
  
  private func setupProfileVC() {
    view.backgroundColor = .tertiarySystemGroupedBackground
    viewMaker.profileTableView.dataSource = self
    viewMaker.profileTableView.delegate = self
    viewMaker.profileTableView.register(
      ProfileTableViewCell.self,
      forCellReuseIdentifier: Constants.TableViewCell.cellIdentifier
    )
  }
  
  private func setupNavigationBar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: Constants.NavigationItemTitle.leftNavBarItem,
      style: .plain,
      target: self,
      action: #selector(onLogOutButtonTapped(_:))
    )
  }
  
  @objc private func onLogOutButtonTapped(_ sender: Any) {
    do {
      try Auth.auth().signOut()
      UserDefaults.standard.isLoggedIn = false
      print("Successfully logged out")
      delegate?.didPressedLogOut()
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  private func fetchUserInfo() {
    guard let userId = Auth.auth().currentUser?.uid else { return }
    usersCollection.document(userId).getDocument { [weak self] (document, error) in
      if let document = document, document.exists {
        let data = document.data()
        let userName = data?["name"] as? String ?? "Anonymous"
        let dateOfBirth = data?["dateOfBirth"] as? String ?? "none"
        let occupation = data?["occupation"] as? String ?? "none"
        let userId = document.documentID
        self?.appUser = AppUser(
          name: userName,
          uid: userId,
          birthDate: dateOfBirth,
          occupation: occupation
        )
      }
    }
  }
  
  private func fetchBallanceInfo() {
    
    guard let userId = Auth.auth().currentUser?.uid else { return }
    usersCollection.document(userId).getDocument { [weak self] (document, error) in
      if let document = document, document.exists {
        let data = document.data()
        if let expences: [String: Any] = data?["expences"] as? [String: Any] {
          expences.keys.forEach {
            let value = ((expences[$0] as? [String: Any])?["amount"]) as? String
            self?.expences.append(.init(type: $0, amount: value ?? "no data"))
          }
        }
        if let incomes: [String: Any] = data?["income"] as? [String: Any] {
          incomes.keys.forEach {
            let value = ((incomes[$0] as? [String: Any])?["amount"]) as? String
            self?.income.append(.init(type: $0, amount: value ?? "no data"))
          }
        }
        _ = data?["title"] as? String ?? "No title"
        _ = data?["amount"] as? String ?? "No amount"
      }
      print("Data successfully fetched")
      self?.viewMaker.profileTableView.reloadData()
    }
  }
  
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Constants.TableViewCell.rowHeight
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let items: [IncomeAndExpences] = (indexPath.section == 0 ? self.income : self.expences)
    (cell as? ProfileTableViewCell)?.configure(with: items[indexPath.row], isExpences: indexPath.section == 1)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return income.count
    } else {
      return expences.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.cellIdentifier, for: indexPath)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10.0))
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 10, height: 30.0))
    label.font = .avenirNextMedium20
    if section == 0 {
      view.backgroundColor = UIColor.customGreen.withAlphaComponent(0.1)
      label.text = "Income"
      label.textAlignment = .center
      label.textColor = .customGreen
    } else {
      view.backgroundColor = UIColor.red.withAlphaComponent(0.1)
      label.text = "Expences"
      label.textAlignment = .center
      label.textColor = .red
    }
    view.addSubview(label)
    view.layer.cornerRadius = 14
    view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    view.layer.masksToBounds = true
    return view
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    return 30
  }
  
  //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
  //      if editingStyle == .delete {
  //        income.remove(at: indexPath.row)
  //        expences.remove(at: indexPath.row)
  //        viewMaker.profileTableView.deleteRows(at: [indexPath], with: .fade)
  //        viewMaker.profileTableView.reloadData()
  //      }
  //    }
  
}

extension ProfileViewController: AddIncomeDelegate {
  
  func addIncome(item: IncomeAndExpences) {
    self.income.append(item)
    self.viewMaker.profileTableView.reloadData()
  }
  
}

extension ProfileViewController: AddExpencesDelegate {
  
  func addExpence(item: IncomeAndExpences) {
    self.expences.append(item)
    self.viewMaker.profileTableView.reloadData()
  }
  
}
