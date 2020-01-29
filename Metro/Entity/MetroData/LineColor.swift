//
//  LineColor.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

struct LineColor: Decodable {
    
    let color: UIColor
    
    enum CodingKeys: String, CodingKey {
      case r, g, b
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let red = try container.decode(Double.self, forKey: .r)
        let green = try container.decode(Double.self, forKey: .g)
        let blue = try container.decode(Double.self, forKey: .b)
        
        color = UIColor(displayP3Red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
    }
}
