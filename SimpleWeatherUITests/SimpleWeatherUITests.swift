//
//  SimpleWeatherUITests.swift
//  SimpleWeatherUITests
//
//  Created by Suraj Pathak on 12/11/15.
//  Copyright © 2015 Laohan. All rights reserved.
//

import XCTest

class SimpleWeatherUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSearchCancelAndSearchValidCity() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let simpleweatherViewNavigationBar = app.navigationBars["SimpleWeather.View"]
        let inputCityNameEgSingaporeSearchField = simpleweatherViewNavigationBar.searchFields["Input City Name. eg. Singapore"]
        inputCityNameEgSingaporeSearchField.tap()
        simpleweatherViewNavigationBar.buttons["Cancel"].tap()
        inputCityNameEgSingaporeSearchField.tap()
        inputCityNameEgSingaporeSearchField.typeText("London\r")
    }
    
    func testInvalidCitySearch() {
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let app = XCUIApplication()
        let inputCityNameEgSingaporeSearchField = app.navigationBars["SimpleWeather.View"].searchFields["Input City Name. eg. Singapore"]
        inputCityNameEgSingaporeSearchField.tap()
        inputCityNameEgSingaporeSearchField.typeText("gtureiurie\r")
        app.alerts["Error"].collectionViews.buttons["OK"].tap()
        
    }

    
}
