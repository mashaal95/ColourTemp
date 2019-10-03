//
//  SensorDataTableViewCell.swift
//  2019S1 Lab 3
//
//  Created by Mashaal on 30/9/19.
//  Copyright © 2019 Michael Wybrow. All rights reserved.
//

import UIKit

class SensorDataTableViewCell: UITableViewCell {

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var luxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
