//
//  ToDoList.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 19/06/22.
//

import SwiftUI

struct GoalList: View {
    @State var imageCategory = "brain.head.profile"
    @State var titleCategory = "Cognition - Independent"
    @State var toDo = "Answering Question"
    @State var titleList = "Cognition"
    @State var isActive = false
    @StateObject var goalModel = GoalViewModel()
    @State var currentWeek: [Date] = []
    @State var toDetail: Bool = false

    var goalDetail : Goal
    
    var listData: [GoalModel] = //[]
    [GoalModel(id: UUID(), image: "brain.head.profile", category: 2 , detail: "Remembering Recent 2", description: "Remembering Recent Activity can be done by asking questions about the details of activity that have just been carried out. For example the activity name, who did they just meet, where were the activity take place, etc. \nCaregiver can help the patient to remembering the detail by telling them directly or giving them clues about the activity.", status: 1, repeatArray: [1,2,3,5]),
     GoalModel(id: UUID(), image: "brain.head.profile", category: 2,detail: "Answering Question", description: "Remembering Recent Activity can be done by asking questions about the details of activity that have just been carried out. For example the activity name, who did they just meet, where were the activity take place, etc. \nCaregiver can help the patient to remembering the detail by telling them directly or giving them clues about the activity.", status: 2, repeatArray: [2,5,7]),
     GoalModel(id: UUID(), image: "brain.head.profile", category: 2, detail: "Reacting to Good News", description: "Remembering Recent Activity can be done by asking questions about the details of activity that have just been carried out. For example the activity name, who did they just meet, where were the activity take place, etc. \nCaregiver can help the patient to remembering the detail by telling them directly or giving them clues about the activity.",status: 0, repeatArray: [4,7])]
    var body: some View {
//        NavigationView{
           
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
                            
                                
                        }
                    }
//                }.padding(.horizontal, 10)
                
//                ScrollView(.vertical){
                    VStack{
                        if listData.count >  0{
                            ForEach(listData) { data in
                                NavigationLink(destination: MobilityDescView(descGoal: data)) {
                                    ListCell(listModel: data)
                                }
                            }
                        }else{
                            EmptyView().frame(width: Utils.width * 0.9, height: .signalingNaN)
                        }
                        
                    }
//                }
                Spacer()
            }.padding(.horizontal, 10)
            }.background(Color("Color-4"))
                .navigationBarTitleDisplayMode(.inline)
//        }.accentColor(.black)
            
    }
}


struct ListCell: View{
    let listModel : GoalModel
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            HStack{
                Image(systemName: listModel.image)
                    .renderingMode(.original)
                    .tint(.pink)
                    .frame(width: 25, height: 21)
                Text("\(listModel.getCategory(status: listModel.category)) - \(listModel.getStatus(status: listModel.status))")
                    .font(.system(size: 16))
                Spacer()
            }
            Text("\(listModel.detail)")
                .padding(.leading)
                .font(.system(size: 21))
        }
        .padding()
        .frame(width: Utils.width - 40)
        .background(.white)
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
    static var previews: some View {
        GoalList(goalDetail: Goal(id: UUID(), label: "", image: "", value: 0, valueTotal: 0, progress: 0))
    }
}


