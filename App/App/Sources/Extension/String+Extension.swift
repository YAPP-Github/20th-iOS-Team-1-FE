//
//  String+Extension.swift
//  App
//
//  Created by Hani on 2022/07/02.
//

import Foundation

extension String {
    func makePrefixBearer() -> String {
        return "Bearer " + self
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    func commentDateStringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        // 2022-08-06T05:39:02.066839Z
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
