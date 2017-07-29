//
//  StationTableViewController.swift
//  json
//
//  Created by Reid Sherman MAT on 7/29/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import UIKit

class StationTableViewController: UITableViewController {
    //MARK: Properties
    
    var stations = [Station]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleStations()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
                return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print (stations.count)
        return stations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "JSONTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? JSONTableViewCell  else {
            fatalError("The dequeued cell is not an instance of JSONTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let station = stations[indexPath.row]
        print(station.name)
        cell.nameLabel.text = station.name
        cell.dateLabel.text = station.date
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Private Functions
    
    private func loadSampleStations() {
        let url = URL(string: "http://www.learnswiftonline.com/Samples/subway.json")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                if let stations_load = json["stations"] as? [[String: AnyObject]] {
                    for station in stations_load {
                        if let s_name = station["stationName"] as? String {
                            if let s_year = station["buildYear"] as? String {
                                guard let current_station = Station(name:s_name, date: s_year) else {
                                    fatalError("Unable to instantiate station")
                                }
                                self.stations += [current_station]
                                print(s_name,s_year)
                            }
                        }
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        
    }
}
