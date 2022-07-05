//
//  ReminderView.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 09/06/22.
//

import SwiftUI

struct ReminderView: View {
    @State var changeView: Bool = false
    @State var selectedDate: String = ""
    @State var typeId: Int
    @State var listData  = [ReminderNetworkModel]()
    @StateObject var reminderModel = ReminderViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Reminders")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Spacer()
                
                VStack{
                    if listData.count >  0{
                        List{
                            ForEach(listData, id: \.id) { data in
                                let dataReminder = ReminderModel(type: data.fields.typeId ?? 1, status: data.fields.statusId ?? 1, repeatArray: [0])
                                
                                ReminderList(listModel: data.fields)
                            }
                            .onDelete(perform: self.deleteRow)
                        }
                    } else {
                        EmptyView().frame(width: Utils.width * 0.9, height: .signalingNaN)
                    }
                }
                
                NavigationLink(destination: AddReminderView(typeId: typeId, selectedTime: selectedDate)) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFill()
                        .frame(width:30, height: 30)
                        .foregroundColor(.black)
                }
                
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .onAppear {
                getListData()
            }
            
        }
        .background(Color("Color-4"))
    }
    
    private func deleteRow(at indexSet: IndexSet) {
        listData.remove(atOffsets: indexSet)
    }
    
    func getListData(){
        NetworkManager.shared.getUserReminder(with: .reminder, endPoint: ReminderAPI.getReminderType(KeychainItem.getToken, typeId, selectedDate)) { reminderData in
            DispatchQueue.main.async {
                listData = reminderData
            }
            print(reminderData)
        }
    }
}

struct ReminderList: View {
    var listModel: ReminderNetworkModelField
    @State var isSelected: Bool = false
    var body: some View {
        HStack{
            Group{
                if listModel.typeId == 0{
                    Image(systemName: "Pill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .padding(.leading, 13)
                        .minimumScaleFactor(0.5)
                } else {
                    Image(systemName: "tablet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .padding(.leading, 13)
                        .minimumScaleFactor(0.5)
                }
                
                HStack{
                    VStack (alignment: .leading, spacing: 8){
                        Text(listModel.title!)
                            .foregroundColor(K.CustomColor.color)
                            .font(.system(size: 24))
                        HStack(spacing: 6){
                            Text(listModel.time!)
                                .foregroundColor(K.CustomColor.color)
                                .font(.system(size: 16))
                                .frame(width: 75)
                                .background(K.CustomColor.color2)
                                .cornerRadius(8)
                            
                            Text(listModel.mediceTaken!)
                                .font(.system(size: 16))
                        }
                    }
                }
            }
            .padding(.vertical, 16)
            Spacer()
            Toggle("", isOn: $isSelected)
                .toggleStyle(CustomToggle(statusId: listModel.statusId ?? 1))
                .padding(.trailing, 24)
        }
        .listRowBackground(Color("Color-4"))
        .listRowSeparator(.hidden)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: K.CustomColor.color2, radius: 16, x: 0, y: 0)
        )
        .frame(width: 350, height: 88, alignment: .leading)
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(typeId: 0)
    }
}
