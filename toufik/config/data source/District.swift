//
//  District.swift
//  toufik
//
//  Created by Ratul Sharker on 23/3/21.
//

import Foundation

struct District : Decodable {
    let districtId: Int
    let name : String
    
    enum CodingKeys: String, CodingKey {
        case districtId = "district_id"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        districtId = try container.decode(Int.self, forKey: .districtId)
        name = try container.decode(String.self, forKey: .name)
    }
}
