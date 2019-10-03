//
//  HistoryCellTableViewCell.swift
//  2019S1 Lab 3
//
//  Created by Laveeshka Mahadea on 3/10/19.
//  Copyright © 2019 Michael Wybrow. All rights reserved.
//

import UIKit

class HistoryCellTableViewCell: UITableViewCell {

    
  
    @IBOutlet weak var historyImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var luminosityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
