//
//  WeatherDetailViewController.swift
//  SimpleWeather
//
//  Created by Suraj Pathak on 12/11/15.
//  Copyright © 2015 Laohan. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UITableViewController {
    
    var cityWeather: CityWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        
        let pullToRefreshText = "Pull To Refresh"
        let pullToRefreshAttributedText = NSMutableAttributedString(string: pullToRefreshText)
        pullToRefreshAttributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, pullToRefreshText.characters.count))
        refreshControl?.attributedTitle = pullToRefreshAttributedText
        refreshControl?.addTarget(self, action: "refreshCurrentCityWeather", forControlEvents: .ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshCurrentCityWeather() {
        if let weather = cityWeather {
            WeatherFetcher.fetch(weather.name, response: {w, e in
                if let error = e {
                    // Show alert
                    let alertController = UIAlertController(title: "Error", message: error as String, preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { alertAction in
                        alertController.dismissViewControllerAnimated(true, completion: nil)
                    }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                } else {
                    self.cityWeather = w!
                }
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            })
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherDetailCell", forIndexPath: indexPath) as! WeatherDetailCell

        if let weather = cityWeather {
            cell.customizeWithCityWeather(weather)
        }

        return cell
    }

}
