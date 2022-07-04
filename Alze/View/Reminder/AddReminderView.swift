//
//  AddReminderView.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 14/06/22.
//

import SwiftUI

struct AddReminderView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var medicineName: String = ""
    @State var beforeAfterEat: String = ""
    @State var onTap: Bool = true
    
    @State var repeats: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @State var repeatDay: [Bool] = [false, false, false, false, false, false, false]
    
    @State var pillModal: Bool = false
    @State var pickTime: Bool = false
    @State var typeId: Int
    @State var selectedTime: String
    
    @StateObject var reminderModel = ReminderViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing:24){
                
                //Medicine Name
                Group{
                    VStack(spacing: 8){
                        Text("Medicine Name")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 20, idealHeight: 20, maxHeight: 20, alignment: .leading)
                            .foregroundColor(.black)
                        
                        TextField("Medicine Name...", text: $medicineName )
                            .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 51, idealHeight: 51, maxHeight: 51)
                            .padding(.leading, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(K.CustomColor.color1)
                            )
                            .colorScheme(.light)
                    }
                }.padding()
                
                //How to use
                Group{
                    VStack(spacing: 8){
                        Text("How To Use")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 20, idealHeight: 20, maxHeight: 20, alignment: .leading)
                            .foregroundColor(.black)
                        
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
                }.padding()
                
                //type and time
                Group{
                    HStack(spacing: 16){
                        //Pill
                        VStack(alignment: .leading, spacing: 8){
                            Text("Type")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                            
                            ZStack{
                                Button {
                                    pillModal = true
                                } label: {
                                    Image(systemName: "pills")
                                        .resizable()
                                        .scaledToFill()
                                        .foregroundColor(K.CustomColor.color1)
                                        .frame(width: 36, height: 36)
                                        .padding(.trailing, 8)
                                    
                                    if typeId == 0 {
                                        Text("Pill")
                                            .font(.system(size: 16))
                                            .foregroundColor(.black)
                                    } else {
                                        Text("Tablet")
                                            .font(.system(size: 16))
                                            .foregroundColor(.black)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .frame(minWidth: 167, idealWidth: 167, maxWidth: .infinity, minHeight: 68, idealHeight: 68, maxHeight: 68)
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(K.CustomColor.color1))
                            }
                        }
                        
                        //Time
                        VStack(alignment: .leading, spacing: 8){
                            Text("Time")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                            
                            Button {
                                pickTime.toggle()
                            } label: {
                                Image(systemName: "clock")
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(K.CustomColor.color1)
                                    .frame(width: 36, height: 36)

                                
                                if selectedTime == "" {
                                    Text(reminderModel.extractWeekDate(date: Date(), format: "HH:mm"))
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                } else {
                                    Text("\(selectedTime)")
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                }
                                
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(minWidth: 167, idealWidth: 167, maxWidth: .infinity, minHeight: 68, idealHeight: 68, maxHeight: 68)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(K.CustomColor.color1))
                        }
                    }
                }.padding()
                
                Group{
                    VStack(spacing: 8){
                        Text("Repeat").font(.system(size: 16))
                            .fontWeight(.medium)
                            .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 20, idealHeight: 20, maxHeight: 20, alignment: .leading)
                            .foregroundColor(.black)
                        
                        HStack(spacing: 10){
                            ForEach(1..<8, id: \.self){ i in
                                Button {
                                    repeatDay[i-1] = !repeatDay[i-1]
                                } label: {
                                    Text(repeats[i-1])
                                        .font(.caption)
                                }
                                .frame(minWidth: 42, idealWidth: 42, minHeight: 42, idealHeight: 42, maxHeight: 42)
                                .foregroundColor(.black)
                                .background(repeatDay[i-1] ? K.CustomColor.color2.cornerRadius(25) : Color.clear.cornerRadius(25))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(K.CustomColor.color1)
                                )
                            }
                            
                        }
                    }.padding()
                }
                
                Spacer()
                
                Group{
                    Button {
                        let reminderData = ReminderNetworkModel(fields: ReminderNetworkModelField(title: medicineName, type: reminderModel.getType(status: typeId ), typeId: typeId, time: selectedTime, mediceTaken: beforeAfterEat, status: "Not Done", statusId: 1, userToken: KeychainItem.getToken))
                        print(reminderData)
                        NetworkManager.shared.postUserReminder(with: .reminder, endPoint: ReminderAPI.postReminder, data: reminderData) { data in
                            print(data)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save Reminder")
                    }
                    .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 51, idealHeight: 51, maxHeight: 51)
                    .foregroundColor(.white)
                    .background(K.CustomColor.color1.cornerRadius(25))
                    
                }.padding()
            }
            PillModalView(pillModal: $pillModal, typeId: $typeId)
            TimeModalView(timeModal: $pickTime, dateString: $selectedTime)
        }
        .background(Color("Color-4"))
    }
}



struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView(typeId: 0, selectedTime: "")
    }
}
