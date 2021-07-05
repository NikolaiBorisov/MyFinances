//
//  AppCoordinator.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 28.06.2021.
//

import UIKit

final class AppCoordinator {
  
  unowned private let window: UIWindow?
  
  private(set) weak var logInScene: UIViewController?
  private(set) weak var tabBar: UIViewController?
  
  private lazy var transitionHandler: UIViewController = {
    let vc = UIStoryboard(name: "TransitionHandler", bundle: nil).instantiateInitialViewController() as! UINavigationController
    vc.setNavigationBarHidden(true, animated: false)
    return vc
  }()
  
  init(window: UIWindow?) {
    self.window = window
  }
  
  func start() {
    self.window?.rootViewController = transitionHandler
    if UserDefaults.standard.isLoggedIn {
      presentMainScene()
    } else {
      presentLogin()
    }
  }
  
  private func presentLogin() {
    let vc = LoginViewController()
    logInScene = vc
    vc.delegate = self
    let nc = UINavigationController(rootViewController: vc)
    nc.modalPresentationStyle = .fullScreen
    transitionHandler.present(nc, animated: true)
  }
  
  private func presentMainScene() {
    let tabBar = TabBarViewController()
    self.tabBar = tabBar
    tabBar.selectedIndex = 2
    tabBar.modalPresentationStyle = .fullScreen
    tabBar.modalTransitionStyle = .flipHorizontal
    if let nc = tabBar.viewControllers?[0] as? UINavigationController,
       let vc = nc.viewControllers.first as? ProfileViewController {
      vc.delegate = self
    }
    transitionHandler.present(tabBar, animated: true)
  }
  
}

extension AppCoordinator: LogInOutput {
  
  func didFinishAuthorization() {
    self.logInScene?.dismiss(animated: true, completion: {
      self.presentMainScene()
    })
  }
  
}

extension AppCoordinator: ProfileViewOutput {
  
  func didPressedLogOut() {
    self.tabBar?.dismiss(animated: true, completion: {
      self.presentLogin()
    })
  }
  
}
