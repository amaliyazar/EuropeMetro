//
//  MoreTableViewPresenterTest.swift
//  MetroTests
//
//  Created by Алексей Махутин on 14.12.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import XCTest

@testable import Metro

class MoreTableViewPresenterTest: XCTestCase {
    
    var presenter: MockMoreTableViewPresenter!

    override func setUp() {
        super.setUp()
        let data = [69, 68, 67, 66, 65, 64, 63, 57, 56, 55, 54, 43, 42, 41, 40, 39, 38]
        presenter = MockMoreTableViewPresenter(viewcontroller: MoreTableView(), data: data)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStartWorkWithDataWhenInit() {
        XCTAssertTrue(presenter.isWorkWithdata, "Not start workwithData when init")
    }
    
    func testGetTypeFunc() {
        var currentStation = presenter.stations[69]!
        XCTAssertNotNil(currentStation,"Not load station")
        let type1 = presenter.getType(station: currentStation, index: 0)
        XCTAssertEqual(type1, StationInfo.StationInfoConfig.start, "type is not start")
        currentStation = presenter.stations[38]!
        let type2 = presenter.getType(station: currentStation, index: 16)
        XCTAssertEqual(type2, StationInfo.StationInfoConfig.end, "type is not end")
        currentStation = presenter.stations[57]!
        let type3 = presenter.getType(station: currentStation, index: 7)
        XCTAssertEqual(type3, StationInfo.StationInfoConfig.transfer, "type is not transfer")
        currentStation = presenter.stations[68]!
        let type4 = presenter.getType(station: currentStation, index: 1)
        XCTAssertEqual(type4, StationInfo.StationInfoConfig.normal, "type is not normal")
    }
    
    func testGetTimeFunction() {
        let testData = [StationInfo(name: "Foo", time: Date(), type: .start, color: .black, id: 1),
                        StationInfo(name: "Bar", time: Date(), type: .start, color: .black, id: 2),
                        StationInfo(name: "Baz", time: Date(), type: .start, color: .black, id: 3)]
        var currentStation = presenter.stations[1]!
        let time = presenter.getTime(station: currentStation, index: 0, compliteData: testData)
        let calendar = Calendar.current
        var result = calendar.isDate(time, equalTo: Date(), toGranularity: .second)
        XCTAssertTrue(result, "time is not equal")
        currentStation = presenter.stations[2]!
        let time2 = presenter.getTime(station: currentStation, index: 1, compliteData: testData)
        result = calendar.isDate(time2, equalTo: time.addingTimeInterval(120), toGranularity: .second)
        XCTAssertTrue(result, "time is not equal")
        currentStation = presenter.stations[3]!
        let time3 = presenter.getTime(station: currentStation, index: 2, compliteData: testData)
        result = calendar.isDate(time3, equalTo: time.addingTimeInterval(180), toGranularity: .second)
        XCTAssertTrue(result, "time is not equal")
    }
    
    func testCompliteData() {
        let data = presenter.getCompliteData()
        XCTAssertNotNil(data, "Data is empty")
        let first = data.first!
        let last = data.last!
        XCTAssertEqual(first.type, .start, "type not start")
        XCTAssertEqual(last.type, .end, "type not end")
        let calendar = Calendar.current
        let result = calendar.isDate(Date(), equalTo: first.time, toGranularity: .minute)
        XCTAssertTrue(result, "time is not equal")
        let result2 = calendar.isDate(Date().addingTimeInterval(3000), equalTo: last.time, toGranularity: .minute)
        XCTAssertTrue(result2, "time is not equal")
        let second = data[1]
        XCTAssertEqual(second.type, .normal, "Not equal Type")
    }
    
    func testfinalWorkWithData() {
        let data = presenter.getCompliteData()
        presenter.finalWorkWithData(compliteData: data)
        XCTAssertFalse(presenter.stationPath.isEmpty, "final path is empty")
        XCTAssertFalse(presenter.stationPath.first!.isEmpty,"final path is empty")
        let first = presenter.stationPath.first!.first!
        let last = presenter.stationPath.first!.last!
        XCTAssertEqual(first.type, .start, "type is not equal")
        XCTAssertEqual(last.type, .transfer, "type is not equal")
        let secondFirst = presenter.stationPath[1].first!
        let secondLast = presenter.stationPath[1].last!
        XCTAssertEqual(secondFirst.type, .transfer, "type is not equal")
        XCTAssertEqual(secondLast.type, .transfer, "type is not equal")
    }
    
    func testWorkWithData() {
        presenter.workWithData()
        XCTAssertFalse(presenter.stationPath.isEmpty,"Not work")
    }

    


}

extension MoreTableViewPresenterTest {
    
    class MockMoreTableViewPresenter: MoreTableViewPresenter {
        var isWorkWithdata = false
        
        override func workWithData() {
            super.workWithData()
            isWorkWithdata = true
        }
        
    }
    
}
