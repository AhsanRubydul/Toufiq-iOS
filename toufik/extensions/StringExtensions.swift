//
//  StringExtensions.swift
//  toufik
//
//  Created by Ratul Sharker on 2/4/21.
//

import Foundation

extension String {
    func removeAMPM() -> String {
        return self.replacingOccurrences(of: "AM", with: "").replacingOccurrences(of: "PM", with: "")
    }
}
