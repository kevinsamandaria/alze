//
//  Home.swift
//  Alze
//
//  Created by Ridho Saputra on 14/06/22.
//

import SwiftUI

struct Reminder: Identifiable {
    var id = UUID()
    var label: String
    var image: String
    var time: String
    var detail: String
}

struct CardReminder: View {
    let reminder: Reminder
    
    var body: some View {
        HStack(spacing: 16) {
            Image(reminder.image)
                .resizable()
                .scaledToFit()
                .foregroundColor(.indigo.opacity(0.5))
                .frame(width: 80, height: 64)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("\(reminder.label)").font(.title2).fontWeight(.medium)
                    .foregroundColor(K.CustomColor.color)
                
                HStack(spacing: 8) {
                    Text("\(reminder.time)")
                        .padding(.vertical, 4)
                        .padding(.horizontal, 18)
                        .background(K.CustomColor.color2)
                        .cornerRadius(8)
                    Text("\(reminder.detail)")
                }
            }
            
            Spacer()
        }
        .frame(width: 296)
        .padding()
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        
    }
}

struct Goal: Identifiable {
    var id = UUID()
    var label: String
    var image: String
    var color: Color
}

struct GoalUser: Identifiable {
    var id = UUID()
    var value: Int
    var valueTotal: Int
    var progress: Int
}

struct CardGoal: View {
    let goal: Goal
    let goalUser: GoalUser
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(goal.label)")
                    .font(.title3)
                    .fontWeight(.regular)
                    .padding(.horizontal, 12)
                    .padding(.top, 12)
                
                HStack(spacing: 0) {
                    Text("\(goalUser.value)")
                        .font(.title)
                        .fontWeight(.regular)
                        .padding(.leading, 12)
                        .padding(.top, 4)
                        .foregroundColor(goal.color)
                    
                    Text("/\(goalUser.valueTotal)")
                        .font(.title)
                        .fontWeight(.regular)
                        .padding(.top, 4)
                }
                
                Spacer()
                
                Text("\(goalUser.progress)%")
                    .font(.title)
                    .fontWeight(.regular)
                    .padding(.bottom, 12)
                    .padding(.horizontal, 12)
                    .foregroundColor(goal.color)
                
            }.frame(width: 172, alignment: .topLeading)
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 8)
                    .opacity(0.3)
                    .foregroundColor(goal.color)
                
                Circle()
                    .trim(from: 0.0, to:  CGFloat(Double(goalUser.progress)/100.0))
                    .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                    .foregroundColor(goal.color)
                    .animation(.linear, value: 1)
                    .rotationEffect(Angle(degrees: 270.0))
                
                Image(goal.image)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .frame(width: 42, height: 42)
                    .background(goal.color)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }
            .frame(width: 64, height: 64, alignment: .bottomLeading)
            .padding(18)
        }
        .frame(width: 172, height: 172, alignment: .topLeading)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.bottom, 8)
        
    }
}

struct Home: View {
    var userData: UserNetworkModelField?
    var columns = [
        GridItem(.adaptive(minimum: 300, maximum: 240), spacing: 16),
        GridItem(.adaptive(minimum: 300, maximum: 240), spacing: 16)
    ]
    
    var goals: [Goal] = [
        Goal(label: "Mobility", image: "ic-mobility", color: K.CustomColor.color5),
        Goal(label: "Cognition", image: "ic-cognition", color: K.CustomColor.color7),
        Goal(label: "Personal Care", image: "ic-personal", color: K.CustomColor.color6),
        Goal(label: "Explore new Activity", image: "ic-explore", color: K.CustomColor.color8)
    ]
    
    var goalsUser: [GoalUser] = [
        GoalUser(value: 2, valueTotal: 4, progress: 48),
        GoalUser(value: 3, valueTotal: 4, progress: 75),
        GoalUser(value: 1, valueTotal: 4, progress: 25),
        GoalUser(value: 0, valueTotal: 4, progress: 0)
    ]
    
    var reminders: [Reminder] = [
        Reminder(label: "Donepozil", image: "Pill", time: "13.00", detail: "After Eat"),
        Reminder(label: "Donepozil", image: "Pill", time: "13.00", detail: "After Eat"),
        Reminder(label: "Donepozil", image: "tablet", time: "13.00", detail: "After Eat"),
        Reminder(label: "Donepozil", image: "tablet", time: "13.00", detail: "After Eat"),
        Reminder(label: "Donepozil", image: "tablet", time: "13.00", detail: "After Eat")
    ]
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 0) {
                
                ZStack(alignment: .leading) {
                    Text("Good Morning, Alze")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            KeychainItem.deleteUserIdentifierFromKeychain()
                        }) {
                            Image(systemName: "bell.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(K.CustomColor.color1)
                        }
                    }
                }
                .padding()
                
                Text("Today's Reminder")
                    .font(.headline)
                    .fontWeight(.regular)
                    .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(reminders) { reminder in
                            NavigationLink(destination: ReminderView(typeId: 0)) {
                                CardReminder(reminder: reminder)
                                
                            }
                        }
                    }.padding(16)
                }
                
                Text("Today's Goal")
                    .font(.headline)
                    .fontWeight(.regular)
                    .padding(.horizontal)
                    .padding(.top, 32)
                
                LazyVGrid(columns: columns, spacing: 8) {
                    
                    ForEach(goals.indices) { row in
                        NavigationLink(destination: GoalList(categoryId: row)) {
                            CardGoal(goal: goals[row], goalUser: goalsUser[row])
                        }
                    }
                }.padding(.vertical).padding(.horizontal)
                
                Spacer()
                
            }.navigationBarTitleDisplayMode(.inline)
        }.accentColor(.black)
            .onAppear{
                let token = "Bearer \(KeychainItem.currentUserIdentifier)"
                print(token)
                NetworkManager.shared.getUserData(with: .user, endPoint: UserAPI.getUser(token)) { userData in
                    DispatchQueue.main.async {
                        print("Tess: \(userData)")
                    }
                }
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(userData: UserNetworkModelField(fullname: "", email: "", token: ""))
            .previewDevice("iPhone 13")
            .previewInterfaceOrientation(.portrait)
    }
}
