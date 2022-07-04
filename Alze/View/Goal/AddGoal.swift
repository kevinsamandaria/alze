//
//  AddGoal.swift
//  Alze
//
//  Created by Ridho Saputra on 15/06/22.
//

import SwiftUI

struct AddGoal: View {
    @Environment(\.presentationMode) var presentationMode
    @State var goalTitle = ""
    @State var description = ""
    @State var selectDate: String
    @StateObject var goalModel = GoalViewModel()
    
    
    @State var repeats: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @State var repeatDay: [Bool] = [false, false, false, false, false, false, false]
    
    @State var categoryId: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Add Goals").font(.system(size: 24, weight: .medium))
            
            Text("Explore Activity").font(.system(size: 16, weight: .medium))
                .padding(6)
                .background(K.CustomColor.color1)
                .cornerRadius(12)
                .foregroundColor(.white)
            
            Group {
                HStack(spacing: 0.0) {
                    Text("Goal Title").font(.system(size: 16, weight: .medium))
                        .padding(.top, 8)
                    
                    Text("*").font(.system(size: 16, weight: .medium))
                        .padding(.top, 8)
                        .foregroundColor(.red)
                }
                
                TextField("Goal Title", text: $goalTitle)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .frame(width: 350, height: 51)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(K.CustomColor.color1)
                    )
                
            }
            
            Group {
                HStack(spacing: 0.0) {
                    Text("Description").font(.system(size: 16, weight: .medium))
                        .padding(.top, 8)
                    
                    Text("*").font(.system(size: 16, weight: .medium))
                        .padding(.top, 8)
                        .foregroundColor(.red)
                }
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $description)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .frame(width: 350, height: 140, alignment: .topLeading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(K.CustomColor.color1)
                        )
                    
                    if description == "" {
                        Text("Write a desc about the activity  …")
                            .font(.system(size: 18, weight: .regular))
                            .opacity(0.25)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 20)
                    }
                }
            }
            
            Text("Repeat").font(.system(size: 16, weight: .medium))
                .padding(.top, 8)
            
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
            
            Spacer()
            Button(action: {
                let goalData = GoalNetworkModel(fields: GoalNetworkModelField(title: goalTitle,category: goalModel.getCategory(status: categoryId), categoryId: categoryId, status: "Not Done",statusId: 0, description: description,createdDate: selectDate, userToken: KeychainItem.getToken))
                print(goalData)
                NetworkManager.shared.postUserGoal(with: .goal, endPoint: GoalAPI.postGoal, data: goalData) { data in
                    print(data)
                }
                self.presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("Done").font(.system(size: 16, weight: .medium))
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(K.CustomColor.color1)
                    .cornerRadius(25)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}

struct AddGoal_Previews: PreviewProvider {
    static var previews: some View {
        AddGoal(selectDate: "", categoryId: 0)
    }
}
