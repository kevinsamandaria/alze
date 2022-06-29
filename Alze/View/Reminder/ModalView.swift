//
//  ModalView.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 23/06/22.
//

import SwiftUI

struct PillModalView: View {
    
    @Binding var pillModal:Bool
    @State private var currHeight:CGFloat = 400
    let minHeight: CGFloat = 400
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if pillModal{
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea(.all)
                    .onTapGesture {
                        pillModal = false
                    }
                
                VStack {
                    ZStack{
                        Button {
                            pillModal.toggle()
                        } label: {
                            Text("Done")
                                .frame(maxWidth:.infinity, alignment:.trailing)
                        }
                    }
                    .padding(20)
                    Text("Hello")
                }
                .frame(height: currHeight)
                .frame(maxWidth: .infinity)
                .background(.white)
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea(.all)
        .animation(.easeInOut)
        
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView()
    }
}

struct TimeModalView: View {
    @Binding var timeModal:Bool
    @State var pickDate: Date = Date()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if timeModal{
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.3)
                
                VStack {
                    ZStack{
                        Button {
                            timeModal.toggle()
                        } label: {
                            Text("Done")
                                .frame(maxWidth:.infinity, alignment:.trailing)
                        }
                    }
                    .padding(20)
                    
                    ZStack{
                        DatePicker("", selection: $pickDate, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                    }
                    .frame(maxHeight: .infinity)
                }
                .frame(height:300)
                .frame(maxWidth: .infinity)
                .background(.white)
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
}

