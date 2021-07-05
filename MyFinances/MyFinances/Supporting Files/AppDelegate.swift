//
//  AppDelegate.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 22.06.2021.
//

import UIKit
import FBSDKCoreKit

// added framework FBSDKCoreKit and updated AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    setupNavBarAppearance()
    
    ApplicationDelegate.shared.application(
      application,
      didFinishLaunchingWithOptions: launchOptions
    )
    return true
  }
  
  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    
    ApplicationDelegate.shared.application(
      app,
      open: url,
      sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
      annotation: options[UIApplication.OpenURLOptionsKey.annotation]
    )
  }
  
  func setupNavBarAppearance() {
    UINavigationBar.appearance().barTintColor = .white
    
    UINavigationBar.appearance().titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.font: UIFont.avenirNextMedium20,
    ]
    UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.avenirNextMedium18], for: .normal)
    UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().barTintColor = .customGreen
    UINavigationBar.appearance().isTranslucent = true
  }
  
}
