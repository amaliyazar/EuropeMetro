//
//  MultiPoint.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

struct MultiPoint: Decodable {
    
    let coords: CGPoint
    let id: [Int]
    
    enum CodingKeys: String, CodingKey {
        case x,y,id,coords
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let coords = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .coords)
        let x = try coords.decode(Double.self, forKey: .x)
        let y = try coords.decode(Double.self, forKey: .y)
        id = try container.decode(Array<Int>.self, forKey: .id)
        self.coords = CGPoint(x: x, y: y)
    }
}
