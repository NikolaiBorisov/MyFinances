//
//  TabBarViewController.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 25.06.2021.
//

import UIKit

final class TabBarViewController: UITabBarController {
  
  private let middleButtonDiameter: CGFloat = 42
  private let middleButtonImageHeight: CGFloat = 30.0
  private let middleButtonImageWidth: CGFloat = 30.0
  
  // MARK:- Setting UI
  
  private lazy var centralButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = middleButtonDiameter / 2
    button.backgroundColor = .customGreen
    button.addTarget(self, action: #selector(didPressCentralButton), for: .touchUpInside)
    return button
  }()
  
  private lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = Constants.Image.briefcaseImage
    imageView.tintColor = .white
    return imageView
  }()
  
  private lazy var tabBarTopLine: CustomTabBarView = {
    let tabBar = CustomTabBarView()
    tabBar.translatesAutoresizingMaskIntoConstraints = false
    return tabBar
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
    setupVCs()
    setupLayouts()
  }
  
  //MARK:- Central TabBar Button Method
  
  @objc private func didPressCentralButton() {
    selectedIndex = 2
    centralButton.backgroundColor = .customGreen
  }
  
  // MARK:- Setting Up TabBar Appearance
  
  private func setupTabBar() {
    UITabBar.appearance().barTintColor = .white
    UITabBar.appearance().tintColor = .customGreen
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: (UIFont.avenirNextMedium10)], for: .normal)
  }
  
  // MARK:- Creating NavController
  
  private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.tabBarItem.title = title
    navController.tabBarItem.image = image
    rootViewController.navigationItem.title = title
    return navController
  }
  
  // MARK:- Setting Up ViewControllers for TabBar
  
  private func setupVCs() {
    guard let image1 = Constants.Image.profileImage,
          let image2 = Constants.Image.dollarsignCircle,
          let image3 = Constants.Image.profileImage,
          let image4 = Constants.Image.minusSignCircle,
          let image5 = Constants.Image.camera
    else { return }
    
    viewControllers = [
      createNavController(
        for: ProfileViewController(),
        title: NSLocalizedString(Constants.TabBarItemTitle.profile, comment: ""),
        image: image1),
      createNavController(
        for: IncomeViewController(),
        title: NSLocalizedString(Constants.TabBarItemTitle.incomes, comment: ""),
        image: image2),
      createNavController(
        for: TotalBallanceViewController(),
        title: NSLocalizedString(Constants.TabBarItemTitle.balance, comment: ""),
        image: image3),
      createNavController(
        for: ExpensesViewController(),
        title: NSLocalizedString(Constants.TabBarItemTitle.expences, comment: ""),
        image: image4),
      createNavController(
        for: ReceiptsViewController(),
        title: NSLocalizedString(Constants.TabBarItemTitle.receipts, comment: ""),
        image: image5)
    ]
  }
  
  // MARK:- Setting Up Layouts for UI Elements
  
  private func setupLayouts() {
    view.addSubview(tabBarTopLine)
    tabBar.addSubview(centralButton)
    view.bringSubviewToFront(tabBar)
    centralButton.addSubview(profileImageView)
    
    NSLayoutConstraint.activate([
      
      centralButton.heightAnchor.constraint(equalToConstant: middleButtonDiameter),
      centralButton.widthAnchor.constraint(equalToConstant: middleButtonDiameter),
      centralButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
      centralButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10.0),
      
      profileImageView.heightAnchor.constraint(equalToConstant: middleButtonImageHeight),
      profileImageView.widthAnchor.constraint(equalToConstant: middleButtonImageWidth),
      profileImageView.centerXAnchor.constraint(equalTo: centralButton.centerXAnchor),
      profileImageView.centerYAnchor.constraint(equalTo: centralButton.centerYAnchor),
      
      tabBarTopLine.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
      tabBarTopLine.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
      tabBarTopLine.widthAnchor.constraint(equalTo: tabBar.widthAnchor),
      tabBarTopLine.heightAnchor.constraint(equalTo: tabBar.heightAnchor)
      
    ])
  }
  
}

// MARK:- TabBar Controller Delegate

extension TabBarViewController: UITabBarControllerDelegate {
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    let selectedIndex = self.tabBar.items?.firstIndex(of: item)
    if selectedIndex != 2 {
      centralButton.backgroundColor = .red
    } else {
      centralButton.backgroundColor = .customGreen
    }
  }
}
