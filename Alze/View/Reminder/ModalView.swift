//
//  ModalView.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 23/06/22.
//

import SwiftUI

struct PillModalView: View {
    
    @Binding var pillModal:Bool
    @Binding var typeId: Int
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
                    .padding(.trailing, 20)
                    
                    ZStack{
                        VStack{
                            Button {
                                typeId = 0
                                pillModal.toggle()
                            } label: {
                                Text("Pill")
                                    .font(.system(size: 25))
                            }
                            Divider()
                            Button {
                                typeId = 1
                                pillModal.toggle()
                            } label: {
                                Text("Tablet")
                                    .font(.system(size: 25))
                            }
                        }
                    }
                    .frame(maxHeight: 150)
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .background(.white)
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea(.all)
        .animation(.easeInOut)
        .colorScheme(.light)
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView(typeId: 0, selectedTime: "")
    }
}

struct TimeModalView: View {
    @Binding var timeModal:Bool
    @State var pickDate: Date = Date()
    @State var dateFormater = DateFormatter()
    @Binding var dateString: String
    
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
                            dateFormater.dateFormat = "HH:mm"
                            dateString = dateFormater.string(from: pickDate)
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
        .colorScheme(.light)
    }
}

