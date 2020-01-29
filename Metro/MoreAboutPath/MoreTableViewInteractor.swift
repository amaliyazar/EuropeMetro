//
//  MoreTableViewInteractor.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import Foundation

protocol MoreTableViewInteractorProtocol {
    var stations: [Int: Station] { get }
    var colors: [LineColor] { get }
    
    
}

class MoreTableViewInteractor {
    
    var data = DataFetcher.share.getMetroData()
    
    var stationsDict: [Int: Station] = [:]
    
    init() {
        data?.stations.forEach{
            stationsDict.updateValue($0, forKey: $0.id)
        }
        updateStationsDict()
    }
    
    func updateStationsDict() {
        data?.stations.forEach{
            stationsDict.updateValue($0, forKey: $0.id)
        }
    }
    
    var stations: [Int: Station] {
        return stationsDict
    }
    
    var colors: [LineColor] {
        return data?.colors ?? []
    }
    
}
