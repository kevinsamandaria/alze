//
//  ReminderView.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 09/06/22.
//

import SwiftUI

struct ReminderView: View {
    @State var isSelected: Bool = false
    @State var changeView: Bool = false
    var medicines: [dummyData] = MedicineList.medicine
    
    var body: some View {
        NavigationView{
            List(medicines, id: \.id){ item in
                HStack{
                    Group{
                        Image(item.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60)
                            .padding(.leading, 13)
                            .minimumScaleFactor(0.5)
                        HStack{
                            VStack (alignment: .leading, spacing: 8){
                                Text(item.medecineName)
                                    .foregroundColor(K.CustomColor.color)
                                    .font(.system(size: 24))
                                HStack(spacing: 6){
                                        Text(item.time)
                                            .foregroundColor(K.CustomColor.color)
                                            .font(.system(size: 16))
                                            .frame(width: 75)
                                            .background(K.CustomColor.color2)
                                            .cornerRadius(8)
                                            
                                        Text(item.afterBeforeEat)
                                            .font(.system(size: 16))
                                }
                            }
                        }
                    }
                    .padding(.vertical, 16)
                    Spacer()
                    Toggle("", isOn: $isSelected)
                        .toggleStyle(CustomToggle())
                        .padding(.trailing, 24)
                }
                .listRowSeparator(.hidden)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .shadow(color: K.CustomColor.color2, radius: 16, x: 0, y: 0)
                )
                .frame(width: 350, height: 88, alignment: .leading)
            }
            .navigationBarTitle("Reminders")
            .navigationBarItems(trailing:
                                    NavigationLink(destination: AddReminderView(), label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFill()
                    .frame(width:30, height: 30)
                    .foregroundColor(.black)
            }))
            .accentColor(.black)
            .listStyle(.plain)
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
