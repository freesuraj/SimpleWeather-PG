//
//  SimpleWeatherTests.swift
//  SimpleWeatherTests
//
//  Created by Suraj Pathak on 12/11/15.
//  Copyright © 2015 Laohan. All rights reserved.
//

import XCTest
@testable import SimpleWeather

class SimpleWeatherTests: XCTestCase {
    
    // MARK: - Constants & Parameters
    static let name = "Singapore"
    static let iconUrl = ""
    static let weatherDesc = "Cloudy"
    static let temperature = "26"
    static let humidity = "80"
    static let updatedAt = NSDate(timeIntervalSince1970: 0)
    
    var cityWeather: CityWeather!
    
    override func setUp() {
        super.setUp()
        cityWeather = CityWeather(name: "Singapore", iconUrl: "", weatherDesc: "Cloudy", temperature: "26", humidity: "80", updatedAt: NSDate(timeIntervalSince1970: 0))
    }
    
    override func tearDown() {
        cityWeather = nil
        super.tearDown()
    }
    
    // MARK: StoreManager
    func testCityWeatherObjectConstruction() {
        XCTAssertNotNil(cityWeather)
        XCTAssertEqual(cityWeather.name, SimpleWeatherTests.name)
        XCTAssertEqual(cityWeather.iconUrl, SimpleWeatherTests.iconUrl)
        XCTAssertEqual(cityWeather.weatherDesc, SimpleWeatherTests.weatherDesc)
        XCTAssertEqual(cityWeather.temperature, SimpleWeatherTests.temperature)
        XCTAssertEqual(cityWeather.humidity, SimpleWeatherTests.humidity)
        XCTAssertEqual(cityWeather.updatedAt, SimpleWeatherTests.updatedAt)
    }
    
    func testStoreManager() {
        StoreManager.addHistoryCityWeather(cityWeather)
        XCTAssertGreaterThanOrEqual(StoreManager.getHistoryCities().count, 1, "After adding one record, must have at least one cityWeather in the store manager")
    }
    
    // MARK: WeatherFetcher
    func testValidCityWeatherFetch() {
        let expectation: XCTestExpectation = self.expectationWithDescription("Fetch Valid City Weather Response")
        
        WeatherFetcher.fetch("Singapore", response: { cw, errorMsg in
            if let error = errorMsg {
                if(error != "No data error") {
                    XCTAssertNotNil(cw, "For Singapore weather response should not be nil")
                }
            } else {
                XCTAssertNotNil(cw, "For Singapore weather response should not be nil")
                XCTAssertNil(errorMsg, "There should be no error for fetching weather of a valid city")
            }
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func testInvalidCityWeatherFetch() {
        let expectation: XCTestExpectation = self.expectationWithDescription("Fetch Invalid City Weather Response")
        WeatherFetcher.fetch("Sdangor", response: { cw, errorMsg in
            XCTAssertNil(cw, "For Invalid city weather response should be nil")
            XCTAssertNotNil(errorMsg, "There should be error message for invalid city")
            XCTAssertTrue((errorMsg == "Unable to find any matching weather location to the query submitted!" || errorMsg == "No data error"), "The error message should match the one returned from API for invalid city")
            expectation.fulfill()
        })
        self.waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func testCorrectDataDecoding() {
        let goodData = NSData(contentsOfFile: NSBundle(forClass: SimpleWeatherTests.self).pathForResource("singapore", ofType: "json")!)
        let results = WeatherFetcher.decode(goodData!)
        XCTAssertNil(results.1, "For good data error message must be nil")
        XCTAssertNotNil(results.0, "For good data city weather returned must not be nil")
        let singapore = results.0!
        XCTAssertEqual(singapore.name, "Singapore, Singapore")
    }
    
    func testErrorDataDecoding() {
        let goodData = NSData(contentsOfFile: NSBundle(forClass: SimpleWeatherTests.self).pathForResource("notFound", ofType: "json")!)
        let results = WeatherFetcher.decode(goodData!)
        XCTAssertNil(results.0, "For error data city weather must be nil")
        XCTAssertNotNil(results.1, "For error data error message must not be nil")
    }
}
