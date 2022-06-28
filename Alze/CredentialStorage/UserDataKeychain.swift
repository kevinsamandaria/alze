//
//  UserDataKeychain.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 09/06/22.
//

import Foundation

struct UserDataKeychain: Keychain {
    
  // Make sure the account name doesn't match the bundle identifier!
  var account = "com.mc2Afternoon3.Alze.Details"
  var service = "userIdentifier"

  typealias DataType = UserData
}
