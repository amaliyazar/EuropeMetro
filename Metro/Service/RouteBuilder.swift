//
//  RouteBuilder.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//
import Foundation


class RouteBuilder {
    
    static let share = RouteBuilder()
    private init() {}
    
    func getTime(path: [Int], data: [Int: Station]) -> Int {
        var result = 0
        for (index,id) in path.enumerated() {
            guard index != path.count - 1 else { break }
            let nextId = path[index + 1]
            guard let time = data[id]?.edges.filter({ $0.id == nextId}).first?.time else { break }
            result += time
        }
        return result
    }
    
    func buildPath(start:Int, end:Int, data: [Int: Station]) -> [Int] {
        let queue = DispatchQueue(label: "wayDispatch",qos: .userInteractive, attributes: .concurrent)
        var way1: [Int] = []
        var way2: [Int] = []
        var way3: [Int] = []
        var time1 = 0
        var time2 = 0
        var time3 = 0
        queue.async{ [unowned self] in
            way1 = self.finder(start: start, end: end, way: 0, data: data)
            time1 = self.getTime(path: way1, data: data)
        }
        
        queue.async{ [unowned self] in
            way2 = self.finder(start: start, end: end, way: 1, data: data)
            time2 = self.getTime(path: way2, data: data)
        }
        
        queue.async{ [unowned self] in
            way3 = self.finder(start: start, end: end, way: 2, data: data)
            time3 = self.getTime(path: way3, data: data)
        }
        
        var result: [Int] = []
        
        
        
        queue.sync(flags: .barrier, execute: {
            NSLog("time for path -- way1 - \(time1),way2 - \(time2),way3 - \(time3)")
            switch min(time1,time2,time3) {
            case time1:
                result = way1
                NSLog("select -- way1")
            case time2:
                result = way2
                NSLog("select -- way2")
            case time3:
                result = way3
                NSLog("select -- way3")
            default:
                result = way1
                NSLog("select -- way1")
            }
        })
        return result
        
    }
    
    func findDirtyPath(start:Int, end:Int, way:Int, data: [Int: Station]) -> [Int] {
        var target = start
        var queen = [target]
        var visit = [Int]()
        
        while true {
            guard !queen.isEmpty else { break }
            target = queen.removeFirst()
            visit.append(target)
            guard target != end else { break }
            var temp = [Station.Edges]()
            switch way {
            case 0:
                temp = data[target]!.edges
            case 1:
                temp = data[target]!.edges.reversed()
            case 2:
                temp = data[target]!.edges.shuffled()
            default:
                temp = []
            }
            temp.forEach {
                guard !queen.contains($0.id) && !visit.contains($0.id) else { return }
                queen.append($0.id)
            }
        }
        return visit.reversed()
    }
    
    func clearPath(dirtyPath: inout [Int], data:[Int: Station]) -> [Int] {
        var path = [dirtyPath.first!]
        var nextStationId: Int
        var currentStationId = dirtyPath.removeFirst()
        while true {
            guard !dirtyPath.isEmpty else { break }
            nextStationId = dirtyPath.first!
            let edges = data[currentStationId]!.edges
            if edges.contains(where: { $0.id == nextStationId }) {
                path.append(nextStationId)
                currentStationId = dirtyPath.removeFirst()
            }else{
                dirtyPath.removeFirst()
            }
        }
        return path.reversed()
    }
    
    func checkForMulti(path: [Int], data: [Int: Station]) -> [Int] {
        var deleteList = [Int]()
        for index in 0..<path.count - 2 {
            let currentId = path[index]
            let nextId = path[index + 1]
            let nextNextId = path[index + 2]
            if data[currentId]!.edges.contains(where: { $0.id == nextNextId }) {
                deleteList.append(nextId)
            }
        }
        return path.filter{ !deleteList.contains($0) }
    }
    
    
    func finder(start:Int, end:Int, way:Int, data: [Int: Station]) -> [Int] {
        guard data.keys.contains(start) || data.keys.contains(end) else { return [] }
        var dirtyPath = findDirtyPath(start: start, end: end, way: way, data: data)
        let clear = clearPath(dirtyPath: &dirtyPath, data: data)
        return checkForMulti(path: clear, data: data)
    }
}
