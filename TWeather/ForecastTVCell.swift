//
//  ForecastTVCell.swift
//  TWeather
//
//  Created by Vladislav Tuleiko on 15.02.22.
//

import UIKit

class ForecastTVCell: UITableViewCell {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var imageLabel: UIImageView!
    
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
