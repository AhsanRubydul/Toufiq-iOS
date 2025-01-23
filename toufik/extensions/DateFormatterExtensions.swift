//
//  DateFormatterExtensions.swift
//  toufik
//
//  Created by Ratul Sharker on 24/3/21.
//

import Foundation

extension DateFormatter {
    
    public static func dateFormat_en_yyyy_MM_dd() -> DateFormatter {
        return dateFormatter(locale: Locale(identifier: "en"), format: "yyyy-MM-dd")
    }
        
    public static func dateFormat_bn_weekDayName() -> DateFormatter {
        return dateFormatter(locale: Locale(identifier: "bn"), format: "EEEE")
    }
    
    public static func dateFormat_bn_dd_MM_yyyy() -> DateFormatter {
        return dateFormatter(locale: Locale(identifier: "bn"), format: "dd-MM-YYYY")
    }
    
    public static func dateFormat_bn_week_dd_MMM_yyyy() -> DateFormatter {
        return dateFormatter(locale: Locale(identifier: "bn"), format: "EEEE, dd MMM yyyy")
    }
    
    public static func dateFormatter(locale: Locale, format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
