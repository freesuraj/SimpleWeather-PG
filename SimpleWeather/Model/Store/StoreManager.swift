//
//  City.swift
//  SimpleWeather
//
//  Created by Suraj Pathak on 12/11/15.
//  Copyright © 2015 Laohan. All rights reserved.
//

import Foundation
import RealmSwift

class CityHistory: Object {
    dynamic var name = ""
    dynamic var updatedAt = NSDate()
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

struct StoreManager {
    static let realm = try! Realm()
    
    static func addHistoryCityWeather(cityWeather: CityWeather) {
        try! realm.write({
            realm.create(CityHistory.self, value: ["name": cityWeather.name], update: true)
        })
    }
    
    static func getHistoryCities() -> [CityHistory] {
        return realm.objects(CityHistory).sorted("updatedAt", ascending: false).toArray(CityHistory.self)
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for result in self {
            if let result = result as? T {
                array.append(result)
            }
        }
        return array
    }
}