//
//  SehriIftarTiming.swift
//  toufik
//
//  Created by Ratul Sharker on 23/3/21.
//

import Foundation

struct SehriIftarTiming : Decodable {
    public let sehriIftarTimingId: Int
    public let districtId: Int
    public let timingOfDate: Date
    public let sehriTime: String
    public let iftariTime: String
    
    private enum CodingKeys: String, CodingKey {
        case sehriIftarTimingId = "sehri_iftar_timing_id"
        case districtId = "district_id"
        case timingOfDate = "timing_of_date"
        case sehriTime = "sehri_time"
        case iftariTime = "iftari_time"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sehriIftarTimingId = try container.decode(Int.self, forKey: .sehriIftarTimingId)
        districtId = try container.decode(Int.self, forKey: .districtId)
        let timingOfDateString = try container.decode(String.self, forKey: .timingOfDate)
        timingOfDate = DateFormatter.dateFormat_en_yyyy_MM_dd().date(from: timingOfDateString)!
        sehriTime = try container.decode(String.self, forKey: .sehriTime)
        iftariTime = try container.decode(String.self, forKey: .iftariTime)
    }
}
