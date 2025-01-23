//
//  UserDefaultsExtensions.swift
//  toufik
//
//  Created by Ratul Sharker on 30/3/21.
//

import Foundation

extension UserDefaults {
    public var read4thAprilAsTodayAndShowRamadanUI: Bool {
        get {
            return bool(forKey: "read4thAprilAsTodayAndShowRamadanUI")
        }
        set {
            setValue(newValue, forKey: "read4thAprilAsTodayAndShowRamadanUI")
        }
    }
    
    public var read15thAprilAsTodayAndShowRamadanUI: Bool {
        get {
            return bool(forKey: "read15thAprilAsTodayAndShowRamadanUI")
        }
        set {
            setValue(newValue, forKey: "read15thAprilAsTodayAndShowRamadanUI")
        }
    }
    
    public var userSelectedDistrictIndex: Int {
        get {
            return integer(forKey: "userSelectedDistrictIndex")
        }
        set {
            return setValue(newValue, forKey: "userSelectedDistrictIndex")
        }
    }
}
