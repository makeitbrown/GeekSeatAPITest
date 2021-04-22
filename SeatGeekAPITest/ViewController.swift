//
//  ViewController.swift
//  SeatGeekAPITest
//
//  Created by Michael Brown on 4/19/21.
//

import UIKit

class ViewController: UIViewController {
    
//    MARK:- Event Detail Specs
    
    @IBOutlet weak var bigEventImage: UIImageView!
    
    @IBOutlet weak var bigTimeLabel: UILabel!
    @IBOutlet weak var bigLocationLabel: UILabel!
    
    
    @IBOutlet weak var favoriteButtonOutlet: UIBarButtonItem!
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        guard let event = currentEvent else { return }
        if let fav = currentEvent?.favorited {
            if fav == false {
                favoriteButtonOutlet.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal, barMetrics: .default)
                FavoritesController.shared.addFavorite(event: event)
            } else {
                favoriteButtonOutlet.setBackgroundImage(UIImage(systemName: "heart"), for: .normal, barMetrics: .default)
                FavoritesController.shared.removeFavorite(event: event)
            }
        } else {
            FavoritesController.shared.addFavorite(event: event)
            favoriteButtonOutlet.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal, barMetrics: .default)
        }
        
    }
    
    var currentEvent: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }

    func updateUI() {
        bigLocationLabel.text = currentEvent?.venue.displayLocation
        bigTimeLabel.text = currentEvent?.timeAndDate
        navigationItem.title = currentEvent?.shortTitle
        
        guard let image = currentEvent?.performers.first,
              let url = URL(string: image.image) else { return }
        EventRequest.ImageFromURL(url: url) { [weak self ] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let events):
                DispatchQueue.main.async {
                    self?.bigEventImage.image = UIImage(data: events)
                }
            }
        }
    }

}

