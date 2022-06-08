//
//  Login.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 08/06/22.
//

import SwiftUI
import AuthenticationServices

struct Login: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationView{
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
                SignInWithAppleButton(.continue) { request in
                     
                } onCompletion: { result in
                        
                }
                .signInWithAppleButtonStyle(
                    colorScheme == .dark ? .white : .black
                )
                .frame(width: 235, height: 45)
                .cornerRadius(25)
                Text("By using our services you are agreeing to our \nTerms and Privacy Statements")
                    .font(.system(size: 11, weight: .light))
                    .multilineTextAlignment(.center)
                    .foregroundColor(K.CustomColor.color1)
                    .padding(.top, 100)
                
            }
//            .navigationTitle("Sign In")
        }
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
