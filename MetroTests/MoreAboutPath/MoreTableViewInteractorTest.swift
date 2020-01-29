//
//  MoreTableViewInteractorTest.swift
//  MetroTests
//
//  Created by Алексей Махутин on 21.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import XCTest
@testable import Metro

class MoreTableViewInteractorTest: XCTestCase {

    var interactor: MockMoreTableViewInteractor!
    
    override func setUp() {
        interactor = MockMoreTableViewInteractor()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testUpdateStationsDictMethod() {
        XCTAssertTrue(interactor.isUpdateStationsDict,"Failed, updateStations method not executed")
    }
    
    func testStationsIsNotEmpty() {
        XCTAssertFalse(interactor.stations.isEmpty, "Failed, stations data is empty")
    }

    func testStationsDictIsNotEmpty() {
        XCTAssertFalse(interactor.stationsDict.isEmpty, "Failed, stations dict is empty")
    }
    
    func testColorsIsNotEmpthy() {
        XCTAssertFalse(interactor.colors.isEmpty, "Failed, not color in list")
    }
}

extension MoreTableViewInteractorTest {
    
    class MockMoreTableViewInteractor: MoreTableViewInteractor {
        var isUpdateStationsDict = false
        
        override func updateStationsDict() {
            super.updateStationsDict()
            isUpdateStationsDict = true
        }
        
    }
    
}
