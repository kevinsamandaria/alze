//
//  SignInWithApple.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 09/06/22.
//

import SwiftUI
import AuthenticationServices

final class SignInWithApple: UIViewRepresentable{
   
    func makeUIView(context: Context) ->  ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
    
}
