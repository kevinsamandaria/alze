//
//  SceneDelegates.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 12/06/22.
//

import UIKit
import SwiftUI
import AuthenticationServices
class SceneDelegate: UIResponder {
  var window: UIWindow?
}

extension SceneDelegate: UIWindowSceneDelegate {
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    let window = UIWindow(windowScene: windowScene)
    let appleIDProvider = ASAuthorizationAppleIDProvider()
      
    appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { [self] (credentialState, error) in
          switch credentialState {
          case .authorized:
              print("The Applaase ID credential is valid.")
              let rootView = Home().environment(\.window, window)
              
              window.rootViewController = UIHostingController(rootView: rootView)

//              break// The Apple ID credential is valid.
          case .revoked, .notFound:
              print("Notfound")
              // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
              let rootView = Login().environment(\.window, window)

              window.rootViewController = UIHostingController(rootView: rootView)
//              DispatchQueue.main.async {
//                  Login()
//              }
          default:
              break
          }
      }

      
    self.window = window
    window.makeKeyAndVisible()
  }
}
