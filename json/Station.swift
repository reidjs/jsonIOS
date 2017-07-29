//
//  Station.swift
//  json
//
//  Created by Reid Sherman MAT on 7/29/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import UIKit

class Station {
    //MARK: Properties
    
    var name: String
    var date: String
    
    //MARK: Initialize
    init?(name: String, date: String) {
        if name.isEmpty || date.isEmpty {
            return nil
        }
        self.name = name
        self.date = date
    }
}
