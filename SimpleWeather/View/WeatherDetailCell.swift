//
//  WeatherDetailCell.swift
//  SimpleWeather
//
//  Created by Suraj Pathak on 12/11/15.
//  Copyright © 2015 Laohan. All rights reserved.
//

import UIKit
import Haneke

class WeatherDetailCell: UITableViewCell {
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var updatedDateLabel: UILabel!
    @IBOutlet var weatherStateImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customizeWithCityWeather(cityWeather: CityWeather) {
        cityNameLabel.text = cityWeather.name
        temperatureLabel.text = cityWeather.temperature + " degree celcius"
        statusLabel.text = cityWeather.weatherDesc
        humidityLabel.text = "Humidity: " + cityWeather.humidity
        updatedDateLabel.text = "Updated at: " + cityWeather.updatedAt.getCurrentShortDate()
        if let imageUrl = NSURL(string: cityWeather.iconUrl) {
            weatherStateImageView.hnk_setImageFromURL(imageUrl)
        }
    }

}

extension NSDate {
    func getCurrentShortDate() -> String {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let dateInFormat = dateFormatter.stringFromDate(self)
        
        return dateInFormat
    }
}
