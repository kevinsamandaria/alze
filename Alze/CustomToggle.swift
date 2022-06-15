//
//  CustomToggle.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 14/06/22.
//

import Foundation
import SwiftUI

struct CustomToggle:ToggleStyle{
    func makeBody(configuration: Configuration) -> some View {
        Button{
            configuration.isOn.toggle()
        } label: {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .foregroundColor(configuration.isOn ? K.CustomColor.color : K.CustomColor.color)
                .frame(width: 40, height: 40)
        }
    }
}

extension ToggleStyle where Self == CustomToggle {
    static var customToggle: CustomToggle{
        return CustomToggle()
    }
}
