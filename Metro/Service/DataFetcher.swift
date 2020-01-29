//
//  DataFetcher.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import Foundation

class DataFetcher {
    
    static let share = DataFetcher()
    
    private init() {}
    
    var data: MetroData?
    
    func getMetroData() -> MetroData? {
        guard let data = DataLoader.share.laodFileToData(filename: dataFile, wtihExtension: "json") else { return nil }
    do {
        let result = try JSONDecoder().decode(MetroData.self, from: data)
        self.data = result
        return result
    }catch{
        NSLog("Failed to load metroData")
        return nil
    }
    
    
    }
}
