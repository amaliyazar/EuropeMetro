//
//  DataLoaderTests.swift
//  EuropeMetroTests
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import XCTest
@testable import Metro

class DataLoaderTests: XCTestCase {
    
    func testTryLoadData() {
        let loader = DataLoader.share
        let data = loader.laodFileToData(filename: "data", wtihExtension: "json")
        let dataNil = loader.laodFileToData(filename: "Foo", wtihExtension: "Bar")

        XCTAssertNotNil(data)
        XCTAssertNil(dataNil)
    }
    
}
