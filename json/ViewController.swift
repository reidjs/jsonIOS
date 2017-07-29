//
//  ViewController.swift
//  json
//
//  Created by Reid Sherman MAT on 7/29/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//
//https://stackoverflow.com/questions/39939143/parse-json-response-with-swift-3
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "http://www.learnswiftonline.com/Samples/subway.json")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                if let stations = json["stations"] as? [[String: AnyObject]] {
                    for station in stations {
                        if let name = station["stationName"] as? String {
                            if let year = station["buildYear"] as? String {
                                print(name,year)
                            }
                        }
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

