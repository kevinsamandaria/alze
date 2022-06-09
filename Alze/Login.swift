//
//  Login.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 08/06/22.
//

import SwiftUI
import UIKit
import AuthenticationServices

struct Login: View {
    @Environment(\.colorScheme) var colorScheme
    @State var appleDelegate: SignInWithAppleDelegates! = nil
    var body: some View {
        ZStack{
            VStack{
                
                Text("Hi there, \nI'm Alze")
                    .font(.system(size: 41, weight: .semibold))
                    .foregroundColor(K.CustomColor.color1)
                Image("pencil").resizable().scaledToFit().frame(width: 100, height: 100, alignment: .center)
                Text("Your new alzheimer's \ncare companion").font(.system(size: 16, weight: .light))
                    .foregroundColor(K.CustomColor.color1).padding(.bottom, 100)
                    .multilineTextAlignment(.center)
                
                Text("Create an account or log in using your Apple ID").font(.system(size: 10, weight: .regular))
                    .foregroundColor(K.CustomColor.color1)
                SignInWithApple()
                    .frame(width: K.screenSize.width * 0.8, height: 45)
                    .cornerRadius(45 / 2)
                    .onTapGesture(perform: showAppleLogin)
//                SignInWithAppleButton(.continue) { request in
//
//                } onCompletion: { result in
//
//                }
//                .signInWithAppleButtonStyle(
//                    colorScheme == .dark ? .white : .black
//                )
//                .frame(width: 280, height: 60)
//                .cornerRadius(30)
                Text("By using our services you are agreeing to our \nTerms and Privacy Statements")
                    .font(.system(size: 11, weight: .light))
                    .multilineTextAlignment(.center)
                    .foregroundColor(K.CustomColor.color1)
                    .padding(.top, 100)
                
            }
        }
        .onAppear{
            self.performExistingAccountSetupFlows()
        }
        
    }
    private func showAppleLogin(){
        let request = ASAuthorizationAppleIDProvider().createRequest()
        
        request.requestedScopes = [.fullName, .email]
        
        performSignIn(using: [request])
    }
    
    
    private func performExistingAccountSetupFlows(){
        let requests = [
            ASAuthorizationAppleIDProvider().createRequest(),
            ASAuthorizationPasswordProvider().createRequest()
        ]
        
        performSignIn(using: requests)
        
    }
    
    private func performSignIn(using requests: [ASAuthorizationRequest]){
        
        appleDelegate = SignInWithAppleDelegates(onSignedIn: { success in
            if success{
                
            }else{
                
            }
        })
        let controller = ASAuthorizationController(authorizationRequests: requests)
        controller.delegate = appleDelegate
        controller.performRequests()
    }
    
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
