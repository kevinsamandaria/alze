//
//  AddReminderView.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 14/06/22.
//

import SwiftUI

struct AddReminderView: View {
    @State var medicineName: String = ""
    @State var beforeAfterEat: String = ""
    @State var onTap: Bool = true
    @State var showModal: Bool = false
    @State var notifToggle: Bool = false
    @State var types: String = "Pill"
    
    var body: some View {
        HStack{
            VStack(spacing:24){
                //Medicine Name
                Group{
                    VStack(spacing: 8){
                        Text("Medicine Name")
                            .font(.system(size: 16))
                            .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 20, idealHeight: 20, maxHeight: 20, alignment: .leading)
                        
                        TextField("Medicine Name...", text: $medicineName )
                            .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 51, idealHeight: 51, maxHeight: 51)
                            .padding(.leading, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(K.CustomColor.color1)
                            )
                    }
                }
                
                
                //How to use
                Group{
                    VStack(spacing: 8){
                        Text("How To Use")
                            .font(.system(size: 16))
                            .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 20, idealHeight: 20, maxHeight: 20, alignment: .leading)
                        HStack(spacing: 16){
                            Button("Before Eat") {
                                self.beforeAfterEat = "Before Eat"
                                self.onTap = true
                            }
                            .frame(minWidth: 167, idealWidth: 167, maxWidth: .infinity, minHeight: 51, idealHeight: 51, maxHeight: 51)
                            .foregroundColor(.black)
                            .background(onTap ? K.CustomColor.color2.cornerRadius(25) : Color.clear.cornerRadius(25))
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(K.CustomColor.color1)
                            )
                            
                            
                            Button("After Eat") {
                                self.beforeAfterEat = "After Eat"
                                self.onTap = false
                            }
                            .frame(minWidth: 167, idealWidth: 167, maxWidth: .infinity, minHeight: 51, idealHeight: 51, maxHeight: 51)
                            .foregroundColor(.black)
                            .background(onTap ? Color.clear.cornerRadius(25) : K.CustomColor.color2.cornerRadius(25))
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(K.CustomColor.color1)
                            )
                        }
                    }
                }
                
                
                //type and time
                Group{
                    HStack(spacing: 16){
                        //Pill
                        VStack(alignment: .leading, spacing: 8){
                            Text("Type")
                                .font(.system(size: 16))
                            ZStack{
                                Button {
                                    showModal = true
                                } label: {
                                    Image(systemName: "pills")
                                        .resizable()
                                        .scaledToFill()
                                        .foregroundColor(K.CustomColor.color1)
                                        .frame(width: 36, height: 36)
                                        .padding(.trailing, 8)
                                    
                                    Text("Pill")
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                        .padding(.trailing, 44)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.black)
                                }
                                .frame(minWidth: 167, idealWidth: 167, maxWidth: .infinity, minHeight: 68, idealHeight: 68, maxHeight: 68)
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(K.CustomColor.color1))
                                .sheet(isPresented: $showModal) {
                                    
                                }
                            }
                        }
                        
                        //Time
                        VStack(alignment: .leading, spacing: 8){
                            Text("Time")
                                .font(.system(size: 16))
                            
                            Button {
                                showModal = true
                            } label: {
                                Image(systemName: "clock")
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(K.CustomColor.color1)
                                    .frame(width: 36, height: 36)
                                    .padding(.leading, 16)
                                
                                Text("11.00")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .padding(.trailing, 32)
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.black)
                            }
                            .frame(minWidth: 167, idealWidth: 167, maxWidth: .infinity, minHeight: 68, idealHeight: 68, maxHeight: 68)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(K.CustomColor.color1))
                        }
                    }
                }
                
                //Notification
                Group{
                    Toggle("Notification", isOn: $notifToggle)
                        .font(.system(size: 24))

                    if notifToggle{
                        Text("hi")
                    }
                }
                
                //calendar
                Group{
                    Text("This is Calendar")
                        
                }
                Spacer()
                Group{
                    Button {
                        onTap = false
                    } label: {
                        Text("Save Reminder")
                    }
                    .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 51, idealHeight: 51, maxHeight: 51)
                    .foregroundColor(.white)
                    .background(K.CustomColor.color1.cornerRadius(25))

                }
            }
        }.padding()
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView()
    }
}
