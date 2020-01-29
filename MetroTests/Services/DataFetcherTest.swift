//
//  DataFetcherTest.swift
//  EuropeMetroTests
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//


import XCTest
@testable import Metro

class DataFetcherTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetFetchData() {
        let fecther = DataFetcher.share
        let json = fecther.getMetroData()
        XCTAssertNotNil(json,"failed to load data ")
        XCTAssertNotNil(fecther.data, "failed to cache data")
        
    }



}
