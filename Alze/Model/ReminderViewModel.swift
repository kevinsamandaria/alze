//
//  ReminderViewModel.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 04/07/22.
//

import Foundation

class ReminderViewModel: ObservableObject {
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
    
    func getType(status: Int) -> String{
        switch status{
        case 0:
            return "Pill"
        case 1:
            return "Tablet"
        default:
            return ""
        }
    }
}
