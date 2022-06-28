//
//  ToDoList.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 19/06/22.
//

import SwiftUI

struct GoalList: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    @State var imageCategory = "brain.head.profile"
    @State var titleCategory = "Cognition - Independent"
    @State var toDo = "Answering Question"
    @State var titleList = "Cognition"
    @State var isActive = false
    @StateObject var goalModel = GoalViewModel()
    @State var currentWeek: [Date] = []
    @State var toDetail: Bool = false
    @State var selectedDate: String = ""
//    var goalDetail : Goal
    var categoryId : Int
    
    @State var listData  = [GoalNetworkModel]()
//    [GoalModel(id: UUID(), image: "brain.head.profile", category: 2 , detail: "Remembering Recent 2", description: "Remembering Recent Activity can be done by asking questions about the details of activity that have just been carried out. For example the activity name, who did they just meet, where were the activity take place, etc. \nCaregiver can help the patient to remembering the detail by telling them directly or giving them clues about the activity.", status: 1, repeatArray: [1,2,3,5]),
//     GoalModel(id: UUID(), image: "brain.head.profile", category: 2,detail: "Answering Question", description: "Remembering Recent Activity can be done by asking questions about the details of activity that have just been carried out. For example the activity name, who did they just meet, where were the activity take place, etc. \nCaregiver can help the patient to remembering the detail by telling them directly or giving them clues about the activity.", status: 2, repeatArray: [2,5,7]),
//     GoalModel(id: UUID(), image: "brain.head.profile", category: 2, detail: "Reacting to Good News", description: "Remembering Recent Activity can be done by asking questions about the details of activity that have just been carried out. For example the activity name, who did they just meet, where were the activity take place, etc. \nCaregiver can help the patient to remembering the detail by telling them directly or giving them clues about the activity.",status: 0, repeatArray: [4,7])]
    var body: some View {
        
        VStack(alignment: .center){
            
            HStack{
                Text("Today's \(goalDetail.label) Goals")
                    .font(.system(size: 24))
                Spacer()
                NavigationLink(destination: AddGoal()) {
                    Image(systemName: "plus")
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                }
            }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            //MARK: - Current Week View
            ScrollView(.vertical, showsIndicators: false){
                HStack(spacing: 8){
                    ForEach(goalModel.currentWeek, id: \.self){day in
                        VStack(spacing: 5){
                            Text(goalModel.extractWeekDate(date: day, format: "EEE"))
                            
                            ZStack{
                                Circle()
                                    .fill(goalModel.isToday(date: day) ? Color("Color-2") : .white)
                                    .frame(width: 43, height: 43)
                                Text(goalModel.extractWeekDate(date: day, format: "d"))
                                
                            }.onTapGesture {
                                goalModel.currentDay = day
                            }
                        }.foregroundColor(.black)
                            .frame(width: 45, height: 90)
                    
                    }.foregroundColor(.black)
                        .frame(width: 45, height: 90)
                    
                }
                
//                ScrollView(.vertical){
                    VStack{
                        if listData.count >  0{
                            ForEach(listData, id: \.id) { data in
                                ListCell(listModel: data.fields)

                                NavigationLink(destination: MobilityDescView(descGoal: data)) {
                                    ListCell(listModel: data)
                                }
                            }
                            .onDelete(perform: self.deleteRow)
                        }.frame(minHeight: minRowHeight * 15)
                    } else {
                        EmptyView().frame(width: Utils.width * 0.9, height: .signalingNaN)
                    }
//                }
                Spacer()
            }.padding(.horizontal, 10)
                    .onAppear{
                        selectedDate = goalModel.extractWeekDate(date: Date(), format: "M/dd/yyyy")
                    }
            }.background(Color("Color-4"))
                .navigationBarTitleDisplayMode(.inline)
                .onAppear{
                   getListData()
                }
    }
    
    private func deleteRow(at indexSet: IndexSet) {
        listData.remove(atOffsets: indexSet)
    }
    func getListData(){
        NetworkManager.shared.getUserGoal(with: .goal, endPoint: GoalAPI.getGoalCategory(KeychainItem.getToken, categoryId,selectedDate)) { goalData in
            DispatchQueue.main.async {
                listData = goalData
            }
            print(goalData)
        }
    }
}


struct ListCell: View{
    let listModel : GoalNetworkModelField
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            HStack{
                Image(systemName: listModel.getImage(categoryId: listModel.categoryId ?? 0))
                    .renderingMode(.original)
                    .tint(.pink)
                Text("\(listModel.getCategory(categoryId: listModel.categoryId ?? 0)) - \(listModel.getStatus(status: listModel.statusId ?? 0))")
                    .font(.system(size: 16))
                    .font(.system(size: 16))
                Spacer()
            Text("\(listModel.title!)")
                .padding(.leading)
                .font(.system(size: 18))
                .font(.system(size: 21))
        }
        .padding(.vertical)
        .padding(.leading, 6)
        .cornerRadius(16)
    }
}

struct EmptyListView: View{
    var body: some View{
        Image(systemName: "square.and.arrow.up.fill")
            .frame(width: Utils.width * 0.9, height: .infinity)
            .background(.pink)
            .scaledToFit()
    }
}

struct ToDoList_Previews: PreviewProvider {
        GoalList(categoryId: 0)
//        GoalList(goalDetail: Goal(id: UUID(), label: "", image: "", value: 0, valueTotal: 0, progress: 0))
//        GoalList(goalDetail: Goal(id: UUID(), label: "", image: "", value: 0, valueTotal: 0, progress: 0))
    }
}


