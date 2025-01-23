//
//  WaktTiming.swift
//  toufik
//
//  Created by Ratul Sharker on 23/3/21.
//

import Foundation

struct WaktTiming: Decodable {
    let waktTimingId: Int
    let districtId: Int

    let fazarTime: String
    let zoharTime: String
    let asarTime: String
    let maghribTime: String
    let ishaTime: String
    
    private enum CodingKeys: String, CodingKey {
        case waktTimingId = "wakt_timing_id"
        case districtId = "district_id"
        
        case fazarTime = "fazar_time"
        case zoharTime = "zohar_time"
        case asarTime = "asar_time"
        case maghribTime = "maghrib_time"
        case ishaTime = "isha_time"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        waktTimingId = try container.decode(Int.self, forKey: .waktTimingId)
        districtId = try container.decode(Int.self, forKey: .districtId)
        
        fazarTime = try container.decode(String.self, forKey: .fazarTime)
        zoharTime = try container.decode(String.self, forKey: .zoharTime)
        asarTime = try container.decode(String.self, forKey: .asarTime)
        maghribTime = try container.decode(String.self, forKey: .maghribTime)
        ishaTime = try container.decode(String.self, forKey: .ishaTime)
    }
}
