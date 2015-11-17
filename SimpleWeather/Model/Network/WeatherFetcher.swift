//
//  WeatherFetcher.swift
//  SimpleWeather
//
//  Created by Suraj Pathak on 12/11/15.
//  Copyright © 2015 Laohan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct WeatherFetcher {
    static func fetch(cityName: String, response: (CityWeather?, NSString?) -> ()) {
        Alamofire.request(.GET, WeatherRequest.url, parameters: WeatherRequest.parameters(cityName))
            .response { _, _, data, _ in
                return response(decode(data!))
        }
    }
    
    static func decode(data: NSData) -> (CityWeather?, NSString?) {
        
        if(data.length == 0) {
            return (nil, "No data error")
        }
        let json = JSON(data: data)
        let error = json["data"]["error"].arrayValue
        if(!error.isEmpty) {
            return (nil, error.first!["msg"].stringValue)
        }
        let currentCondition = json["data"]["current_condition"].arrayValue.first
        let request = json["data"]["request"].arrayValue.first
        let name = request!["query"].stringValue
        let temp = currentCondition!["temp_C"].stringValue
        let humidity = currentCondition!["humidity"].stringValue
        let weatherDescArray = currentCondition!["weatherDesc"].arrayValue
        let weatherDesc = weatherDescArray.first!["value"].stringValue
        let weatherIconUrlArray = currentCondition!["weatherIconUrl"].arrayValue
        let weatherIconUrl = weatherIconUrlArray.first!["value"].stringValue

        return (CityWeather(name: name, iconUrl: weatherIconUrl, weatherDesc: weatherDesc, temperature: temp, humidity: humidity, updatedAt: NSDate()), nil)
    }
}