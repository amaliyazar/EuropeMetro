//
//  MoreTableViewPresenter.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import Foundation

protocol MoreTableViewPresenterProtocol {
    
    var stationPath: [[StationInfo]] { get }
    
}

class MoreTableViewPresenter: MoreTableViewPresenterProtocol {
    
    weak var view: MoreTableView!
    let interactor = MoreTableViewInteractor()
    
    private var data: [Int] = []
    
    init(viewcontroller: MoreTableView,data: [Int]) {
        view = viewcontroller
        self.data = data
        workWithData()
    }
    
    var stations: [Int: Station] {
        return interactor.stationsDict
    }
    
    var colors: [LineColor] {
        return interactor.colors
    }

    
    var stationPath: [[StationInfo]] = []
    
    func finalWorkWithData(compliteData: [StationInfo]) {
        stationPath = []
        var saveIndex = 0.5
        stationPath.append([])
        for i in 0..<compliteData.count {
            let station = compliteData[i]
            if stationPath.count - 1 != Int(saveIndex) {
                stationPath.append([])
            }
            if station.type == .transfer {
                stationPath[Int(saveIndex)].append(station)
                saveIndex += 0.5
                continue
            }
            stationPath[Int(saveIndex)].append(station)
        }
    }
    
    func getType(station: Station, index: Int) -> StationInfo.StationInfoConfig {
        //check start or end
        var type: StationInfo.StationInfoConfig = .normal
        switch index {
        case 0: type = .start
        case data.count - 1: type = .end
        default: type = .normal
        }
        
        //check transfers
        if station.multi {
            let nextStation = stations[data[index + 1]]
            let prevStation = stations[data[index - 1]]
            switch type {
            case .start:
                if station.line != nextStation?.line { type = .transfer }
            case .end:
                if station.line != prevStation?.line { type = .transfer }
            default:
                if station.line != nextStation?.line || station.line != prevStation?.line { type = .transfer }
            }
        }
        return type
    }
    
    func getTime(station: Station, index: Int, compliteData: [StationInfo]) -> Date {
        if index == 0 {
            return Date()
        }else{
            let prevStations = compliteData[index - 1]
            let time = prevStations.time
            let calendar = Calendar.current
            var timeWay = 0
            let oldStation = stations[prevStations.id]
            let edge = oldStation?.edges.filter{ $0.id == station.id }.first!
            timeWay = edge?.time ?? 0
            return calendar.date(byAdding: .second, value: timeWay, to: time)!
        }
    }
    
    func getCompliteData() -> [StationInfo] {
        var compliteData = [StationInfo]()
        data.enumerated().forEach {
            let currentStation = stations[$0.element]!
            let type = getType(station: currentStation, index: $0.offset)
            let time = getTime(station: currentStation, index: $0.offset, compliteData: compliteData)
            let text = currentStation.name["ru_RU"]!
            let color = colors[currentStation.line - 1].color
            
            compliteData.append(StationInfo(name: text, time: time, type: type, color: color, id: currentStation.id))
        }
        return compliteData
    }
    
    func workWithData() {
        let compliteData = getCompliteData()
        finalWorkWithData(compliteData: compliteData)
    }
    
}
