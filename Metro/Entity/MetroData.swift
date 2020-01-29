//
//  MetroData.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//
import UIKit

struct MetroData: Decodable {
    
    var stations: [Station]
    let multiPoints: [MultiPoint]
    let lines: [[LineBetweenStations]]
    var colors: [LineColor]
    
    
}
