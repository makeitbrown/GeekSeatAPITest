//
//  MainTableViewCell.swift
//  SeatGeekAPITest
//
//  Created by Michael Brown on 4/19/21.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
//    MARK:- Cell Properties
    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellUI(currentSearch: Venue) {
        eventTitleLabel.text = currentSearch.short_title
        locationLabel.text = currentSearch.display_location
        timeLabel.text = currentSearch.datetime_utc
        
//        eventImage.image = currentSearch.performers
    }

}
