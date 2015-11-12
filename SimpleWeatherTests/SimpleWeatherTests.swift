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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Test StoreManager
    func testStoreManager() {
        XCTAssertNotNil(StoreManager.getHistoryCities(), "History cities can be empty but not nil")
    }
    
    // Test WeatherFetcher
    func testWeatherFetcher() {
        WeatherFetcher.fetch("Singapore", response: { cw, errorMsg in
            XCTAssertNotNil(cw, "For Singapore weather response should not be nil")
            XCTAssertNil(errorMsg, "There should be no error for fetching weather of a valid city")
        })
        
        WeatherFetcher.fetch("Sdangor", response: { cw, errorMsg in
            XCTAssertNil(cw, "For Invalid city weather response should be nil")
            XCTAssertNotNil(errorMsg, "There should be error message for invalid city")
            XCTAssertEqual(errorMsg, "Unable to find any matching weather location to the query submitted!", "The error message should match the one returned from API for invalid city")
        })
    }
}
