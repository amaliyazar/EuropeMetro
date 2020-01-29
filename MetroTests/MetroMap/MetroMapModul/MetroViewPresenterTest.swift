//
//  MetroViewPresenterTest.swift
//  EuropeMetroTests
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//


import XCTest
@testable import Metro

class MetroViewPresenterTest: XCTestCase {
    
    var presenter: MetroViewPresenter!

    override func setUp() {
        super.setUp()
        presenter = MetroViewPresenter(bind: MetroView())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLinesIsNotEmpty() {
        XCTAssertFalse(presenter.lines.isEmpty, "Data with point of line beetwen station is clear")
    }
    
    func testMultiStationsIsNotEmpty() {
        XCTAssertFalse(presenter.multiStations.isEmpty, "Data with point of line beetwen station is clear")
    }
    
    func testStationsIsNotEmpty() {
        XCTAssertFalse(presenter.stations.isEmpty, "Data with point of line beetwen station is clear")
    }
    
    func testLineColorIsNotEmpty() {
        XCTAssertFalse(presenter.lineColors.isEmpty, "Data with point of line beetwen station is clear")
    }

    func testGetColorForLineWithStationId() {
        let color = presenter.getColorForLine(withStation: 1)!
        let color2 = presenter.lineColors[0].color
        XCTAssertEqual(color, color2, "Colors is not equal")
    }
}
