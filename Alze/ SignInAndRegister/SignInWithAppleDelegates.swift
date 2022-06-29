//
//  SignInWithAppleDelegate.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 09/06/22.
//

import UIKit
import SwiftUI
import AuthenticationServices
import Contacts

class SignInWithAppleDelegates: NSObject {
    private let signInSucceeded: (Bool) -> Void
    private weak var window: UIWindow!
    
    
    init(window: UIWindow?, onSignedIn: @escaping(Bool) -> Void){
        self.window = window
        self.signInSucceeded = onSignedIn
    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("\n -- ASAuthorizationControllerDelegate -\(#function) -- \n")
        print(error)
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential{
        case let appleCredential as ASAuthorizationAppleIDCredential:
            AppManager.Authenticated.send(true)
            
            if let _ = appleCredential.email, let _ = appleCredential.fullName{
                createNewAccount(credential: appleCredential)
            }else{
                signInWithExitingAccount(credential: appleCredential)

            }

            break
        case let passwordCredential as ASPasswordCredential:
            AppManager.Authenticated.send(true)
            signInWithUserNamePassword(credential: passwordCredential)
            break
        default:
           break
        }
    }
    
    private func signInWithUserNamePassword(credential: ASPasswordCredential){
        self.signInSucceeded(true)
    }
    
    
    
    private func createNewAccount(credential: ASAuthorizationAppleIDCredential){
        let token  = "Bearer \(credential.user)"
        guard let name = credential.fullName, let email = credential.email else{
            return
        }
        let fullName = displayName(name: name)
        let userNetwork = UserNetworkModel(fields: UserNetworkModelField(fullname: fullName, email: email, token: token))
        NetworkManager.shared.getUserData(with: .user, endPoint: UserAPI.getUser(token)) { userData in
            print(userData)
            if userData.id == nil{
                NetworkManager.shared.registerUser(with: .user, endPoint: UserAPI.postUser, data: userNetwork) { data in
                    print(data)
                }
            }
        }
        do{
            try KeychainItem(service: "com.mc2Afternoon3.Alze.details", account: "userIdentifier").saveItem(credential.user)
            print(KeychainItem.currentUserIdentifier)
            self.signInSucceeded(true)

        } catch{
            self.signInSucceeded(false)
        }
    }
    
    func displayName(style: PersonNameComponentsFormatter.Style = .default, name: PersonNameComponents) -> String {
        PersonNameComponentsFormatter.localizedString(from: name, style: style)
    }
    
    private func signInWithExitingAccount(credential: ASAuthorizationAppleIDCredential){
        do{
            try KeychainItem(service: "com.mc2Afternoon3.Alze.details", account: "userIdentifier").saveItem(credential.user)
            print(KeychainItem.currentUserIdentifier)
            self.signInSucceeded(true)

        } catch{
            self.signInSucceeded(false)
        }
        self.signInSucceeded(true)
    }
    
}

extension SignInWithAppleDelegates: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window
    }
}
