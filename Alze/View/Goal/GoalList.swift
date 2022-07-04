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
    var categoryId : Int
    
    @State var listData  = [GoalNetworkModel]()
    var body: some View {
        
        VStack(alignment: .center){
            
            HStack{
                Text("Today's \(goalModel.getCategory(status: categoryId)) Goals")
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                Spacer()
                NavigationLink(destination: AddGoal(selectDate: selectedDate, categoryId: categoryId)) {
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
                                selectedDate = goalModel.extractWeekDate(date: day, format: "M/dd/yyyy")
                                
                                getListData()
                            }
                        }.foregroundColor(.black)
                            .frame(width: 45, height: 90)
                        
                    }
                    
                }
                
                VStack{
                    if listData.count >  0{
                        List{
                            ForEach(listData, id: \.id) { data in
                                
                                let dataGoal = GoalModel(category: data.fields.categoryId ?? 0, detail: data.fields.title ?? "", description: data.fields.description ?? "", status: data.fields.statusId ?? 0, repeatArray: [0])
                                NavigationLink(destination: MobilityDescView(descGoal: dataGoal)) {
                                    ListCell(listModel: data.fields)
                                }
                            }
                            .onDelete(perform: self.deleteRow)
                        }.frame(minHeight: minRowHeight * 15)
                    } else {
                        EmptyView().frame(width: Utils.width * 0.9, height: .signalingNaN)
                    }
                }
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
        NetworkManager.shared.deleteUserGoal(with: .goal, endPoint: GoalAPI.deleteGoal(String(listData[1].fields.id ?? 0))) {
            goalData in DispatchQueue.main.async {
                
            }
            print(goalData)
        }
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
            }
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
    static var previews: some View{
        GoalList(categoryId: 0)
    }
}


