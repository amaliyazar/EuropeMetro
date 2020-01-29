//
//  MetroViewInteractorTest.swift
//  EuropeMetroTests
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//


import XCTest
@testable import Metro

class MetroViewInteractorTest: XCTestCase {
    
    var interactor: MetroViewInteractor!

    override func setUp() {
        super.setUp()
        interactor = MetroViewInteractor()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetLinesIsNotEmpty() {
        let lines = interactor.getLines
        XCTAssertFalse(lines.isEmpty, "Data with point of line beetwen station is clear")
    }
    
    func testGetMultiPointsIsNotEmpty() {
        XCTAssertFalse(interactor.getMultiStations.isEmpty, "Data with point of line beetwen station is clear")
    }
    
    func testGetStationsIsNotEmpty() {
        XCTAssertFalse(interactor.getStations.isEmpty, "Data with point of line beetwen station is clear")
    }
    
    func testGetgetLineColorIsNotEmpty() {
        XCTAssertFalse(interactor.getLineColor.isEmpty, "Data with point of line beetwen station is clear")
    }
    
    

}
