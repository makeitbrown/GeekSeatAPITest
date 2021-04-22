//
//  FavoritesController.swift
//  SeatGeekAPITest
//
//  Created by Michael Brown on 4/20/21.
//

import Foundation

struct FavoritesController {
    static var shared = FavoritesController()
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var archiveURL: URL { documentsDirectory.appendingPathComponent("FavEvent_data").appendingPathExtension("plist")
    }

    var favoritedEvents: [Event] = []
    

    func addFavorite(event: Event) {
        FavoritesController.shared.favoritedEvents.append(event)
        saveToFile()
    }
    
    func removeFavorite(event: Event) {
        if let eventsIndex = FavoritesController.shared.favoritedEvents.index(of: event) {
            FavoritesController.shared.favoritedEvents.remove(at: eventsIndex)
            saveToFile()
        }
    }
    //    MARK:- Add to listOfFavoritedEvents

    func saveToFile() {
        let favs = FavoritesController.shared.favoritedEvents
        let propertyListEncoder = PropertyListEncoder()
        let encodedFavs = try? propertyListEncoder.encode(favs)
        
        try? encodedFavs?.write(to: archiveURL, options: .noFileProtection)
    }
    
//    MARK:- Load from File
    func loadFromFile() -> [Event] {
        let propertyListDecoder = PropertyListDecoder()
        
        if let retrievedFavsData = try? Data(contentsOf: archiveURL),
           let decodedFavs = try? propertyListDecoder.decode([Event].self, from: retrievedFavsData) {
            return decodedFavs
        }
        return FavoritesController.shared.favoritedEvents
    }

}
