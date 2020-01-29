//
//  MetroDataTest.swift
//  EuropeMetroTests
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//


import Foundation
import XCTest
@testable import Metro


class MetroDataTest: XCTestCase {

    func testCreateLineColorFromJsonWithDecoder() {
        let json = """
        {"r": 212, "g": 40.8, "b": 61}
        """.data(using: .utf8)!
        let lineColor = try? JSONDecoder().decode(LineColor.self, from: json)
        
        let handInputColor = UIColor(displayP3Red: 212/255, green: 40.8/255, blue: 61/255, alpha: 1)
        // test not nill
        XCTAssertNotNil(lineColor)
        //test color space
        XCTAssertEqual(lineColor?.color.hashValue, handInputColor.hashValue)
        
    }
    
    func testCreateLineBeetwenStationsWithDecoder() {
        
        let json = """
        {"from":38,"to":39}
        """.data(using: .utf8)!
        
        let line = try? JSONDecoder().decode(LineBetweenStations.self, from: json)
        // test not nill
        XCTAssertNotNil(line)
        // test from == from to == to
        XCTAssertEqual(line?.fromId, 38)
        XCTAssertEqual(line?.toId, 39)
        
    }
    
    func testCreateMultiPointsWithDecoder() {
        let json = """
        {"coords": {"x": 40.5, "y": 64.37}, "id": [7,27]}
        """.data(using: .utf8)!
        
        let multiPoint = try? JSONDecoder().decode(MultiPoint.self, from: json)
        
        //test not nill
        XCTAssertNotNil(multiPoint)
        
        //test for equal
        XCTAssertEqual(multiPoint?.coords.x, 40.5)
        XCTAssertEqual(multiPoint?.coords.y, 64.37)
        XCTAssertEqual(multiPoint?.id,[7,27])
    }
    
    func testCreateStationWithDecoder() {
        let json = """
        {
            "id": 1,
            "coords": { "x": 20, "y": 95 },
            "multi": false,
            "name": {"ru_RU": "проспект ветеранов","en_EN": "prospekt veteranov"},
            "edges": [{"time": 120,"id": 2}],
            "line": 1
        }
        """.data(using: .utf8)!
        
        let station = try? JSONDecoder().decode(Station.self, from: json)
        
        //test not nill
        XCTAssertNotNil(station)
        
        //test for equal
        XCTAssertEqual(station?.coords, CGPoint(x: 20, y: 95))
        XCTAssertEqual(station?.id, 1)
        XCTAssertEqual(station?.multi, false)
        XCTAssertEqual(station?.edges.first?.time, 120)
        XCTAssertEqual(station?.edges.first?.id, 2)
        XCTAssertEqual(station?.name["ru_RU"], "проспект ветеранов")
        XCTAssertEqual(station?.line, 1)
    }
    
    func testCreateMetroDataWithDecoder() {
        let data = DataLoader.share.laodFileToData(filename: "data", wtihExtension: "json")!
        
        let metroData = try? JSONDecoder().decode(MetroData.self, from: data)
        
        XCTAssertNotNil(metroData)
    }
    

}
