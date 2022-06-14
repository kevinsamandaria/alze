//
//  SignInWithAppleDelegate.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 09/06/22.
//

import UIKit
import AuthenticationServices
import Contacts

class SignInWithAppleDelegates: NSObject {
    private let signInSucceeded: (Bool) -> Void
    private weak var window: UIWindow!
    
    init(window: UIWindow?, onSignedIn: @escaping(Bool) -> Void){
        self.window = window
        self.signInSucceeded = onSignedIn
    }
//    init(onSignedIn: @escaping(Bool) -> Void){
//        self.signInSucceeded = onSignedIn
//    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("\n -- ASAuthorizationControllerDelegate -\(#function) -- \n")
        print(error)
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential{
        case let appleCredential as ASAuthorizationAppleIDCredential:
            if let _ = appleCredential.email, let _ = appleCredential.fullName{
                createNewAccount(credential: appleCredential)
            }else{
                signInWithExitingAccount(credential: appleCredential)
            }
            break
        case let passwordCredential as ASPasswordCredential:
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
        let userData = UserData(email: credential.email!, name: credential.fullName!, identifier: credential.user)
        
        let keychain = UserDataKeychain()
        
        do{
            try keychain.store(userData)
            print(userData.identifier)
        } catch{
            self.signInSucceeded(false)
        }
        
        do{
            let success = try WebApi.Register(user: userData, identityToken: credential.identityToken, authorizationCode: credential.authorizationCode)
            self.signInSucceeded(success)
        }catch{
            self.signInSucceeded(false)
        }
    }
    
    private func signInWithExitingAccount(credential: ASAuthorizationAppleIDCredential){
        
        self.signInSucceeded(true)
    }
    
}

extension SignInWithAppleDelegates: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window
    }
}
