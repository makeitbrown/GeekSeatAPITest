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
    
    func updateCellUI(currentSearch: Event) {
        eventTitleLabel.text = currentSearch.shortTitle
        locationLabel.text = currentSearch.venue.displayLocation
        timeLabel.text = currentSearch.timeAndDate
        guard let image = currentSearch.performers.first,
              let url = URL(string: image.image) else { return }
        EventRequest.ImageFromURL(url: url) { [ weak self ] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let events):
//                (data) in
            DispatchQueue.main.async {
                self?.eventImage.image = UIImage(data: events)
            }
        }
//        eventImage.image = currentSearch.venue.performers.image
    }
    
}
}
