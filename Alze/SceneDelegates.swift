//
//  SceneDelegates.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 12/06/22.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder {
  var window: UIWindow?
}

extension SceneDelegate: UIWindowSceneDelegate {
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    let window = UIWindow(windowScene: windowScene)

    let rootView = Login().environment(\.window, window)
    
    window.rootViewController = UIHostingController(rootView: rootView)
    self.window = window
    window.makeKeyAndVisible()
  }
}
