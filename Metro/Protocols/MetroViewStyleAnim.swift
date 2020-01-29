//
//  MetroViewStyleAnim.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import Foundation

enum MetroViewStyleAnimType {
    case tap, untap, route, unroute, normal
}

protocol MetroViewStyleAnim {
    
    func setStyle(style: MetroViewStyleAnimType)
    
}
