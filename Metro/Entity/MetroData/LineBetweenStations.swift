//
//  LineBetweenStations.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//
import Foundation

struct LineBetweenStations: Decodable {
    let fromId: Int
    let toId: Int
    
    enum CodingKeys: String, CodingKey {
        case from, to
    }
    
    init(fromId: Int, toId: Int) {
        self.fromId = fromId
        self.toId = toId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fromId = try container.decode(Int.self, forKey: .from)
        toId = try container.decode(Int.self, forKey: .to)
    }
}
