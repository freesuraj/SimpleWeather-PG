//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Suraj Pathak on 12/11/15.
//  Copyright © 2015 Laohan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    var searchBar: UISearchBar = UISearchBar()
    @IBOutlet var tableView: UITableView!
    var cities: [CityHistory] = []
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup search bar
        searchBar.delegate = self
        searchBar.placeholder = "Input City Name. eg. Singapore"
        searchBar.showsCancelButton = true
        self.navigationItem.titleView = searchBar
        tableView.hidden = true
        
        // Setup tableViewCell
        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        cities = StoreManager.getHistoryCities()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        tableView.hidden = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if(!searchBar.text!.isEmpty) {
            tryToFetchCityWeather(searchBar.text!)
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        tableView.hidden = true
    }
    
    // MARK: UITableViewDataSource
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(cities.count, 10)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let city: CityHistory = cities[indexPath.row]
        cell.textLabel?.text = city.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let city: CityHistory = cities[indexPath.row]
        tryToFetchCityWeather(city.name)
    }
    
    // MARK: Helper
    func tryToFetchCityWeather(cityName: String) {
        WeatherFetcher.fetch(cityName, response: { cityWeather, error in
            if let e = error {
                // Show alert
                let alertController = UIAlertController(title: "Error", message: e as String, preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { alertAction in
                    alertController.dismissViewControllerAnimated(true, completion: nil)
                }))
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                // Go to weather detail page
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("WeatherDetailViewController") as? WeatherDetailViewController {
                    vc.cityWeather = cityWeather!
                    // Add this city to history list
                    StoreManager.addHistoryCityWeather(cityWeather!)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        })
    }
    

}

