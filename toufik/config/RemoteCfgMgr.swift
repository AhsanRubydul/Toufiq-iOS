//
//  RemoteConfig.swift
//  toufik
//
//  Created by Ratul Sharker on 6/3/21.
//

import Foundation
import FirebaseRemoteConfig

class RemoteCfgMgr {

    static let CONFIG_FETCHED_NOTIFICATION = "REMOTE_CONFIG_FETCHED_NOTIFICATION"
    
    private let RAMADAN_START_DATE_KEY = "ramadan_start_date"
    private let RAMADAN_END_DATE_KEY = "ramadan_end_date"
    private let SHOW_RAMADAN_GUI_KEY = "show_ramadan_gui"
    
    static let sharedInstance = RemoteCfgMgr()
    private let remoteConfig: RemoteConfig

    
    private init() {
        remoteConfig = RemoteConfig.remoteConfig()
        
        remoteConfig.setDefaults(fromPlist: "Config")
        
        remoteConfig.fetchAndActivate { (status, error) in
            if let _ = error {
                print("Error in fetching remote config and activate")
            } else {
                print("Remote config fetch status is ", status.rawValue)
                let nc = NotificationCenter.default
                nc.post(Notification(name: Notification.Name(rawValue: RemoteCfgMgr.CONFIG_FETCHED_NOTIFICATION)))
            }
        }
    }
    
    func ramadanStartDate() -> Date? {
        guard let ramadanStartDateStr = remoteConfig.configValue(forKey: RAMADAN_START_DATE_KEY).stringValue else {
            return nil
        }
        
        guard let startDate = DateFormatter.dateFormat_en_yyyy_MM_dd().date(from: ramadanStartDateStr) else {
            return nil
        }
        
        return startDate
    }
    
    func ramadanEndDate() -> Date? {
        guard let ramadanEndDateStr = remoteConfig.configValue(forKey: RAMADAN_END_DATE_KEY).stringValue else {
            return nil
        }
        
        guard let endDate = DateFormatter.dateFormat_en_yyyy_MM_dd().date(from: ramadanEndDateStr) else {
            return nil
        }
        
        return endDate.endOfDate()
    }
    
    func isRamdanRunning() -> Bool {

        guard let ramadanStartDate = ramadanStartDate() else {
            return false
        }

        guard let ramadanEndDate = ramadanEndDate() else {
            return false
        }

        let todayLocal = Date.today()

        print("isRamadanRunning ?")
        print(ramadanStartDate)
        print(ramadanEndDate)
        print(todayLocal)

        return todayLocal >= ramadanStartDate && todayLocal <= ramadanEndDate
    }

    func shouldShowRamdanUI() -> Bool {
        if UserDefaults.standard.read15thAprilAsTodayAndShowRamadanUI || UserDefaults.standard.read4thAprilAsTodayAndShowRamadanUI {
            return true
        } else {
            return remoteConfig.configValue(forKey: SHOW_RAMADAN_GUI_KEY).boolValue;
        }
    }
}
