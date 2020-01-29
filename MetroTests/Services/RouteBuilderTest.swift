//
//  RouteBuilderTest.swift
//  EuropeMetroTests
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//


import XCTest
@testable import Metro

class RouteBuilderTest: XCTestCase {
    
    var data: [Int: Station]?

    override func setUp() {
        super.setUp()
        loadData()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func loadData() {
        if data == nil {
            let preData = DataFetcher.share.getMetroData()
            data = [:]
            preData?.stations.forEach{
                data?.updateValue($0, forKey: $0.id)
            }
        }
    }

    func testGetTimeFunction() {
        let path = [1,2]
        let path2 = [1,2,3,4]

        guard let data = data else {
            XCTFail()
            return
        }
        let time1 = RouteBuilder.share.getTime(path: path, data: data)
        let time2 = RouteBuilder.share.getTime(path: path2, data: data)
        XCTAssertEqual(time1, 120, "Time is not equal")
        XCTAssertEqual(time2, 420, "Time is not equal")
    }
    
    func testBuildPathIsWork() {
        guard let data = data else {
            XCTFail()
            return
        }
        
        let path = [69, 68, 67, 66, 65, 64, 63, 57, 56, 55, 54, 43, 42, 41, 40, 39, 38]
        let path2 = RouteBuilder.share.buildPath(start: 69, end: 38, data: data)
        XCTAssertEqual(path, path2, "path is not equal")
    }

    func testFindDirtyPathIsWork() {
        guard let data = data else {
            XCTFail()
            return
        }
        
        let path = RouteBuilder.share.findDirtyPath(start: 69, end: 38, way: 0, data: data)
        let path2 = [ 38, 37, 16, 39, 36, 20, 15, 1, 50, 40, 35, 21, 14, 2, 51, 49, 41, 34, 22, 13, 3, 52, 48, 42, 33, 23, 12, 4, 53, 47, 43, 32, 24, 11, 5, 58, 54, 46, 44, 31, 25, 10, 6, 59, 55, 45, 30, 26, 9, 7, 60, 56, 29, 27, 8, 61, 57, 28, 62, 63, 70, 64, 65, 66, 67, 68, 69]
        XCTAssertEqual(path2, path, "path is not Equal")
    }
    
    func testClearPathIsWork() {
        guard let data = data else {
            XCTFail()
            return
        }
        var path = [ 38, 37, 16, 39, 36, 20, 15, 1, 50, 40, 35, 21, 14, 2, 51, 49, 41, 34, 22, 13, 3, 52, 48, 42, 33, 23, 12, 4, 53, 47, 43, 32, 24, 11, 5, 58, 54, 46, 44, 31, 25, 10, 6, 59, 55, 45, 30, 26, 9, 7, 60, 56, 29, 27, 8, 61, 57, 28, 62, 63, 70, 64, 65, 66, 67, 68, 69 ]
        let finPath = [69, 68, 67, 66, 65, 64, 63, 28, 57, 56, 55, 54, 43, 42, 41, 40, 39, 38]
        let tryPath = RouteBuilder.share.clearPath(dirtyPath: &path, data: data)
        XCTAssertEqual(finPath, tryPath, " Not clear path ")
    }
    
    func testClearMulti() {
        guard let data = data else {
            XCTFail()
            return
        }
        let path = [69, 68, 67, 66, 65, 64, 63, 28, 57, 56, 55, 54, 43, 42, 41, 40, 39, 38]
        let finPath = [69, 68, 67, 66, 65, 64, 63, 57, 56, 55, 54, 43, 42, 41, 40, 39, 38]
        let tryPath = RouteBuilder.share.checkForMulti(path: path, data: data)
        XCTAssertEqual(tryPath, finPath, "Not clear multi")
    }
    
    func testFinder() {
        guard let data = data else {
            XCTFail()
            return
        }
        let path = [69, 68, 67, 66, 65, 64, 63, 57, 56, 55, 54, 43, 42, 41, 40, 39, 38]
        let newPath = RouteBuilder.share.finder(start: 69, end: 38, way: 0, data: data)
        XCTAssertEqual(path, newPath, " path is not equal")
    }

    func testFinishBuildPath() {
        guard let data = data else {
            XCTFail()
            return
        }
        let path = [69, 68, 67, 66, 65, 64, 63, 57, 56, 55, 54, 43, 42, 41, 40, 39, 38]
        let newPath = RouteBuilder.share.buildPath(start: 69, end: 38, data: data)
        XCTAssertEqual(path, newPath, " path is not equal")
    }

}
