//
//  AppData.swift
//  toufik
//
//  Created by Ratul Sharker on 19/3/21.
//

import SQLite

class AppData {
    
    public static let sharedInstance = AppData()

    private let conn : Connection!
    private let district : Table!
    private let waktTiming: Table!
    private let sehriIftarTiming: Table!
    
    
    private init()  {
        let dbURL = Bundle.main.url(forResource: "data", withExtension: "sqlite", subdirectory: "data")!
        do {
            conn = try Connection(dbURL.path, readonly: true)
            dateFormatter.dateFormat = "YYYY-MM-dd"     // https://github.com/stephencelis/SQLite.swift/issues/985#issuecomment-582824879
            dateFormatter.timeZone = .current

            #if DEBUG
            conn.trace { (str) in
                print(str)
            }
            #endif

            district = Table("district")
            waktTiming = Table("wakt_timing")
            sehriIftarTiming = Table("sehri_iftari_timing")
        } catch {
            print("Error initialising db connection")
            print(error)
            
            conn = nil
            
            district = nil
            waktTiming = nil
            sehriIftarTiming = nil
        }
        print("Init completed")
    }
    
    public func getDivisions() -> [District]? {
        let districtId = Expression<Int>("district_id")
        do {
            return try conn.prepare(district.order(districtId.asc)).map({ (row) -> District in
                return try row.decode()
            })
        } catch {
            print(error)
            return nil
        }
    }
    
    public func getTodaysWakTimingForDistrictId(districtId: Int) -> WaktTiming? {
        let timingOfDateExp = Expression<Date>("timing_of_date")
        let districtIdExp = Expression<Int>("district_id")
        let today = Date.today()
        do {
            return try conn.pluck(waktTiming.filter(timingOfDateExp == today && districtIdExp == districtId)).map({ (row) -> WaktTiming in
                return try row.decode()
            })
        } catch {
            print(error)
            return nil
        }
    }
    
    public func getTodaysSehriIftarTimingForDistrict(districtId: Int) -> SehriIftarTiming? {
        
        let timingOfDateExp = Expression<Date>("timing_of_date")
        let districtIdExp = Expression<Int>("district_id")
        
        let today = Date.today()
        print("Today : ", today)
        
        do {
            return try conn.pluck(sehriIftarTiming.filter(timingOfDateExp == today && districtIdExp == districtId)).map({ (row) -> SehriIftarTiming in
                return try row.decode()
            })
        } catch {
            print(error)
            return nil
        }
    }
    
    public func getAllSehriIftarTimingForDistrict(districtId: Int, from: Date?, to: Date?) -> [SehriIftarTiming]? {
        let districtIdExp = Expression<Int>("district_id")
        let timingOfDate = Expression<Date>("timing_of_date")
        
        var expression = (districtIdExp == districtId)
        if let fromDate = from {
            expression = expression && timingOfDate >= fromDate
        }
        
        if let toDate = to {
            expression = expression && timingOfDate <= toDate
        }
        
        let clauses = sehriIftarTiming.order(timingOfDate.asc).filter(expression)
        
        do {
            return try conn.prepare(clauses).map({ (row) -> SehriIftarTiming in
                return try row.decode()
            })
        } catch {
            print(error)
            return nil
        }
    }
    
    public func getAllDuas() -> [Dua]? {
        guard let duaJsonFilePath = Bundle.main.url(forResource: "dua", withExtension: "json", subdirectory: "data") else {
            print("dua file url resolve error")
            return nil
        }
        
        guard let duaData = try? Data(contentsOf: duaJsonFilePath) else {
            print("dua file read error")
            return nil
        }
        
        guard let duas = try? JSONDecoder().decode([Dua].self, from: duaData) else {
            print("dua.json json parsing error")
            return nil
        }
        
        return duas
    }
    
    public func getAllSuras() -> [Sura]? {
        guard let suraJsonFilePath = Bundle.main.url(forResource: "sura", withExtension: "json", subdirectory: "data") else {
            print("sura file url resolve error")
            return nil
        }
        
        guard let suraData = try? Data(contentsOf: suraJsonFilePath) else {
            print("sura file read error")
            return nil
        }
        
        guard let suras = try? JSONDecoder().decode([Sura].self, from: suraData) else {
            print("sura.json json parsing error")
            return nil
        }
        
        return suras
    }
}
