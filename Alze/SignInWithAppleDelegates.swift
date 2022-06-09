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
}

extension SignInWithAppleDelegates: ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
    }
}
