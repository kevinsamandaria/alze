//
//  CustomToggle.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 14/06/22.
//

import Foundation
import SwiftUI

struct CustomToggle:ToggleStyle{
    @State var statusId: Int
    func makeBody(configuration: Configuration) -> some View {
        Button{
            configuration.isOn.toggle()
        } label: {
            if statusId == 0{
                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .foregroundColor(configuration.isOn ? K.CustomColor.color : K.CustomColor.color)
                    .frame(width: 40, height: 40)
            } else {
                Image(systemName: "square")
                    .resizable()
                    .foregroundColor(configuration.isOn ? K.CustomColor.color : K.CustomColor.color)
                    .frame(width: 40, height: 40)
            }
            
        }
    }
}

extension ToggleStyle where Self == CustomToggle {
    static var customToggle: CustomToggle{
        return CustomToggle(statusId: 1)
    }
}
