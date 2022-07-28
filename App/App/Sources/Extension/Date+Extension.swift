//
//  Date+Extension.swift
//  App
//
//  Created by 김나희 on 7/28/22.
//

import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func toString() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
           dateFormatter.timeZone = TimeZone(identifier: "UTC")
           return dateFormatter.string(from: self)
       }
    
    func monthDayWeekDay() -> String {
        "\(self.get(.month))월 \(self.get(.day))일(\(Weekday.init(rawValue: self.get(.weekday))?.korean ?? "월"))"
    }
    
    func hourMinute() -> String {
        let hour = self.get(.hour) < 10 ? "0\(self.get(.hour))" : "\(self.get(.hour))"
        let minute = self.get(.minute) < 10 ? "0\(self.get(.minute))" : "\(self.get(.minute))"
        
        return "\(hour):\(minute)"
    }
    
    func toDateLabelText() -> String {
        return monthDayWeekDay() + " " + hourMinute()
    }
}
