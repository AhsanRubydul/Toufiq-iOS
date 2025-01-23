//
//  NumberForamtter.swift
//  toufik
//
//  Created by Ratul Sharker on 24/3/21.
//

import Foundation

extension NumberFormatter {
    
    public static func numberFormatter_bn() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "bn_bd")
        return formatter
    }
    
}
