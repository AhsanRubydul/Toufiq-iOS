//
//  DateExtensions.swift
//  toufik
//
//  Created by Ratul Sharker on 24/3/21.
//

import Foundation

extension Date {
    public static func today() -> Date {
        
        if UserDefaults.standard.read15thAprilAsTodayAndShowRamadanUI {
            return DateFormatter.dateFormat_en_yyyy_MM_dd().date(from: "2021-04-15")!
        }
        else if UserDefaults.standard.read4thAprilAsTodayAndShowRamadanUI {
            return DateFormatter.dateFormat_en_yyyy_MM_dd().date(from: "2021-04-04")!
        } else {
            return Date()
        }
    }
    
    public func endOfDate() -> Date? {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)
    }
}
