//
//  MetroViewTest.swift
//  EuropeMetroTests
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import XCTest
@testable import Metro

class MetroViewTest: XCTestCase {
    
    var metroView: MockMetroView!

    override func setUp() {
        super.setUp()
        metroView = MockMetroView()
        metroView.layoutSubviews()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMetroViewContentLineBeetwenStationsWhenLayouSubviews() {
        let stations = metroView.subviews.filter{ $0 is StationConnectionView }
        XCTAssertFalse(stations.isEmpty, "Dont load subviews StationConnectionView in MetroView")
    }
    
    func testMetroViewContentMetroDonatOneWhenLayouSubviews() {
        let stations = metroView.subviews.filter{ $0 is MetroDonatOne }
        XCTAssertFalse(stations.isEmpty, "Dont load subviews MetroDonatOne in MetroView")
    }
    
    func testMetroViewContentFromToButtonsWhenLayouSubviews() {
        let stations = metroView.subviews.filter{ $0 is FromToButtons }
        XCTAssertFalse(stations.isEmpty, "Dont load subviews FromToButtons in MetroView")
    }
    
    func testMetroViewContentMultiStationViewWhenLayouSubviews() {
        let stations = metroView.subviews.filter{ $0 is MultiStationView }
        XCTAssertFalse(stations.isEmpty, "Dont load subviews MultiStationView in MetroView")
    }
    
    func testMetroViewPointSetupWhenLayoutSubviews() {
        XCTAssertTrue(metroView.isPointSetup, "Failed pointSetup method not executed")
    }
    
    func testMetroViewMultiStationsInitWhenLayoutSubviews() {
        XCTAssertTrue(metroView.ismultiStationsInit, "Failed multiStationsInit method not executed")
    }
    
    func testMetroViewFineTuningTextWhenLayoutSubviews() {
        XCTAssertTrue(metroView.isfineTuningText, "Failed fineTuningText method not executed")
    }
    
    func testMetroViewStationConnectInitWhenLayoutSubviews() {
        XCTAssertTrue(metroView.isStationConnectInit, "Failed stationConnectInit method not executed")
    }
    
    func testMetroViewCoordsForLinesInitWhenLayoutSubviews() {
        XCTAssertTrue(metroView.isCoordsForLinesInit, "Failed coordsForLinesInit method not executed")
    }
    
    func testMetroViewDrawStationWayOnMapWhenpressFromOrToButton() {
        metroView.pressFromButton(sender: UIView())
        XCTAssertTrue(metroView.isDrawStationWayOnMap, "Failed drawStationWayOnMap when press fromButton")
        metroView.isDrawStationWayOnMap = false
        metroView.pressToButton(sender: UIView())
        XCTAssertTrue(metroView.isDrawStationWayOnMap, "Failed drawStationWayOnMap when press toButton")
    }
    
    func testMetroViewSetMarkerWhenTapOnDonat() {
        metroView.pressFromButton(sender: UIView())
        XCTAssertTrue(metroView.isSetMarker, "Failed setMarker dont call when press from button")
        metroView.isSetMarker = false
        metroView.pressToButton(sender: UIView())
        XCTAssertTrue(metroView.isSetMarker, "Failed setMarker dont call when press to button")
    }
    
    
    func testMetroViewPressToButtonWhenFromToButtonPress() {
        let toButton = metroView.subviews.filter{ $0 is FromToButtons }.first
        (toButton as! FromToButtons).pressToButton()
        XCTAssertTrue(metroView.isPressToButton, "Failed pressToButton method not executed when pressToButton")
    }
    
    func testMetroViewPressFromButtonWhenLayoutSubviews() {
        let fromButton = metroView.subviews.filter{ $0 is FromToButtons }.first
        (fromButton as! FromToButtons).pressFromButton()
        XCTAssertTrue(metroView.isPressFromButton, "Failed pressFromButton method not executed when pressFromButton")
    }
    
    func testMetroViewTapOnDonatWhenTapOnDonat() {
        let donat = metroView.subviews.filter{ $0 is MetroDonatOne }.first
        (donat as! MetroDonatOne).handleTap()
        XCTAssertTrue(metroView.isTapOnDonat, "Failed tapOnDonat method not executed when tap on donat")
    }
    
    func testMetroViewPressTextStationWhenLayoutSubviews() {
        let donat = metroView.subviews.filter{ $0 is TextStationView }.first
        (donat as! TextStationView).pressText()
        XCTAssertTrue(metroView.isPressTextStation, "Failed pressTextStation method not executed when press on text")
    }
    

}

extension MetroViewTest {
    class MockMetroView: MetroView {
        var isPointSetup = false
        var ismultiStationsInit = false
        var isfineTuningText = false
        var isStationConnectInit = false
        var isCoordsForLinesInit = false
        var isDrawStationWayOnMap = false
        var isUpdateFromToSclae = false
        var isSetMarker = false
        var isResotreMapDefault = false
        var isPressToButton = false
        var isPressFromButton = false
        var isTapOnDonat = false
        var isPressTextStation = false
        
        
        override func pointSetup() {
            super.pointSetup()
            self.isPointSetup = true
        }
        
        override func multiStationsInit() {
            super.multiStationsInit()
            self.ismultiStationsInit = true
        }
        
        override func fineTuningText(id: Int, text: TextStationView, view: MetroDonatOne) -> TextStationView {
            self.isfineTuningText = true
            return super.fineTuningText(id: id, text: text, view: view)
        }
        
        override func stationConnectInit() {
            super.stationConnectInit()
            self.isStationConnectInit = true
        }
        
        override func coordsForLinesInit(LineBetweenStationsList: [LineBetweenStations], multiCoords: [Int : CGPoint]) -> [CoordsBetweenStationsWithColor] {
            self.isCoordsForLinesInit = true
            return super.coordsForLinesInit(LineBetweenStationsList: LineBetweenStationsList, multiCoords: multiCoords)
        }
        
        override func drawStationWayOnMap() {
            super.drawStationWayOnMap()
            self.isDrawStationWayOnMap = true
        }
        
        override func updateFromToScale() {
            super.updateFromToScale()
            self.isUpdateFromToSclae = true
        }
        
        override func setMarker(wordAorB: MarkerViewWord) {
            super.setMarker(wordAorB: wordAorB)
            self.isSetMarker = true
        }
        
        override func restoreMapToDefault() {
            super.restoreMapToDefault()
            self.isResotreMapDefault = true
        }
        
        override func pressToButton(sender: UIView) {
            super.pressToButton(sender: sender)
            self.isPressToButton = true
        }
        
        override func pressFromButton(sender: UIView) {
            super.pressFromButton(sender: sender)
            self.isPressFromButton = true
        }
        
        override func tapOnDonat(sender: MetroDonatOne) {
            super.tapOnDonat(sender: sender)
            self.isTapOnDonat = true
        }
        
        override func pressTextStation(sender: TextStationView) {
            super.pressTextStation(sender: sender)
            self.isPressTextStation = true
        }
    }
    
}
