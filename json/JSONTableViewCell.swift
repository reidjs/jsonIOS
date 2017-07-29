//
//  JSONTableViewCell.swift
//  json
//
//  Created by Reid Sherman MAT on 7/29/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import UIKit

class JSONTableViewCell: UITableViewCell {
    //MARK:Properties 
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
