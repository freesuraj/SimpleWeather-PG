//
//  OpenWeatherMap.swift
//  SimpleWeather
//
//  Created by Suraj Pathak on 12/11/15.
//  Copyright © 2015 Laohan. All rights reserved.
//

struct WeatherRequest {
    private static let apiKey = "vzkjnx2j5f88vyn5dhvvqkzc"
    static let url = "http://api.worldweatheronline.com/free/v1/weather.ashx"
    
    static func parameters(cityName: String) -> [String: String] {
        return [
            "key": apiKey,
            "fx" : "yes",
            "format": "json",
            "q": cityName
        ]
    }
}