//
//  EnvironmentWindowKey.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 09/06/22.
//

import UIKit
import SwiftUI

struct WindowKey: EnvironmentKey {
  struct Value {
    weak var value: UIWindow?
  }
  
  static let defaultValue: Value = .init(value: nil)
}

extension EnvironmentValues {
  var window: UIWindow? {
    get { return self[WindowKey.self].value }
    set { self[WindowKey.self] = .init(value: newValue) }
  }
}
