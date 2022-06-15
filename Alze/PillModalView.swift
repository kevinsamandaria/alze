//
//  PillModalView.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 15/06/22.
//

import SwiftUI

struct PillModalView: View {
    @Binding var isShow: Bool
    
    var body: some View {
        ZStack{
            Button(action: {
                isShow = false
            }) {
                Image(systemName: "xmart")
                    .foregroundColor(.black)
            }
            
            VStack{
                Button("Pill") {
                   
                }
                Button("Tablet"){
                    
                }
                Button("Syrup"){
                    
                }
            }
        }
    }
}

struct PillModalView_Previews: PreviewProvider {
    static var previews: some View {
        PillModalView(isShow: .constant(true))
    }
}
