//
//  DataLoader.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import Foundation

class DataLoader {
    
    static let share = DataLoader()
    
    private init () {}
    
    func laodFileToData(filename: String,wtihExtension: String) -> Data? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: wtihExtension), let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
    
}
