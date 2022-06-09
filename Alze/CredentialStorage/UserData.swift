//
//  CredentialStorage.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 09/06/22.
//


import Foundation

/// Represents the details about the user which were provided during initial registration.
struct UserData: Codable {
  /// The email address to use for user communications.  Remember it might be a relay!
  let email: String

  /// The components which make up the user's name.  See `displayName(style:)`
  let name: PersonNameComponents

  /// The team scoped identifier Apple provided to represent this user.
  let identifier: String

  /// Returns the localized name for the person
  /// - Parameter style: The `PersonNameComponentsFormatter.Style` to use for the display.
  func displayName(style: PersonNameComponentsFormatter.Style = .default) -> String {
    PersonNameComponentsFormatter.localizedString(from: name, style: style)
  }
}
