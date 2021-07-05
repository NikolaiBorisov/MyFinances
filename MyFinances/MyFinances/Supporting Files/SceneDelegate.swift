//
//  SceneDelegate.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 22.06.2021.
//

import UIKit
import Firebase
import FirebaseStorage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  override init() {
     super.init()
     FirebaseApp.configure()
  }
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.makeKeyAndVisible()
    
    let coordinator = AppCoordinator(window: self.window)
    coordinator.start()
    
    //FirebaseApp.configure()
    
  }
  
}
