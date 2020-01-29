//
//  StationInfo.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

struct StationInfo {
    enum StationInfoConfig {
        case start, end, normal, transfer
    }
    let name: String
    let time: Date
    let type: StationInfoConfig
    let color: UIColor
    let id: Int
}
