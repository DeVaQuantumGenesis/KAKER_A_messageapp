//
//  Date.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/29.
//

import Foundation
import FirebaseFirestore

extension Date{
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    private var dayFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "HH/dd/yy"
        return formatter
    }
    
    private func timestring() -> String{
        return timeFormatter.string(from: self)
    }
    
    private func dateString() -> String{
        return dayFormatter.string(from: self)
    }
    func timestampString() -> String{
        if Calendar.current.isDateInToday(self){
            return timestring()
        } else if Calendar.current.isDateInYesterday(self){
            return "Yesterday"
        } else {
            return dateString()
        }
    }
}
