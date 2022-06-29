//
//  GoalViewModel.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 21/06/22.
//

import SwiftUI

class GoalViewModel: ObservableObject{
    init(){
        getCurrentWeek()
    }
    @Published var currentWeek: [Date] = []
    @Published var currentDay : Date = Date()
    @Published var currWeek: Int = 26
    func getCurrentWeek(){
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: currentDay)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        (1...7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekDay)
            }
        }
    }
    
    func extractWeekDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    func isToday(date: Date) -> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    func getCategory(status: Int) -> String{
        switch status{
        case 0:
            return "Mobility"
        case 1:
            return "Cognition"
        case 2:
            return "Personal Care"
        case 3:
            return "Explore new Activity"
        default:
            return ""
        }
    }
}

extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
}
extension Date {
    var cureentWeekMonday: Date {
        return Calendar.iso8601.date(from: Calendar.iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
    var currentWeekdays: [Date] {
        return (1...7).compactMap{ Calendar.iso8601.date(byAdding: DateComponents(day: $0), to: cureentWeekMonday) } // for Swift versions earlier than 4.1 use flatMap instead
    }
}
