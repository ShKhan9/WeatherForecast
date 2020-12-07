//
//  MainTableCell.swift
//  WeatherForecast
//
//  Created by MacBook Pro on 12/7/20.
//  Copyright © 2020 MailMedia. All rights reserved.
//

import UIKit

class MainTableCell: UITableViewCell {
    
    // IB Outlets
    @IBOutlet weak var timelb: UILabel!
    @IBOutlet weak var img: ImageLoader!
    @IBOutlet weak var templb: UILabel!
    @IBOutlet weak var windlb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
