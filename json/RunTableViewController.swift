//
//  RunTableViewController.swift
//  json
//
//  Created by Reid Sherman MAT on 7/29/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import UIKit

class RunTableViewController: UITableViewController {
    //MARK: Properties
    
    var all_runs = [Run]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var x: [Run]
        x = [Run(name:"name", day:"day", time:"time", location:"loc")!]
        all_runs += x
        //print("R:", runs)
        loadSampleRuns()
        print("R2:", all_runs)
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
        //print("run cnt: ", runs.count)
        return all_runs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("HERE")
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RunTableViewCell"
        //print("HERE2")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RunTableViewCell  else {
            fatalError("The dequeued cell is not an instance of RunTableViewCell.")
        }
        //print("HERE3")
        // Fetches the appropriate meal for the data source layout.
        
        let run = all_runs[indexPath.row]
        cell.nameLabel.text = run.name
        cell.dayLabel.text = run.day
        cell.timeLabel.text = run.time
        cell.locationLabel.text = run.location
        //print(run.name)
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
    
     private func loadSampleRuns(){
        let url = URL(string: "http://reidsherman.com/runs.json")
        URLSession.shared.dataTask(with:url!, completionHandler:
            {(data, response, error) in
                guard let data = data, error == nil else { return }
                do {
                    //print("here2")
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                    if let runs_load = json["runs"] as? [[String: AnyObject]] {
                        for run in runs_load {
                            //print("here3")
                            if let r_name = run["runName"] as? String {
                                if let r_day = run["runDay"] as? String {
                                    if let r_time = run["runTime"] as? String {
                                        if let r_location = run["runLocation"] as? String {
                                            guard let current_run = Run(name:r_name, day: r_day, time: r_time, location: r_location) else {
                                                fatalError("Unable to instantiate run")
                                            }
                                        
                                            self.all_runs += [current_run]
                                            print(self.all_runs)
                                            self.tableView.reloadData()
                                        }
                                    }
                                }
                            }
                        }
                    }
                } catch let error as NSError {
                print(error)
                }
        }).resume()
        //print("a: ", priv_runs)
        //runs = priv_runs
    }
}
