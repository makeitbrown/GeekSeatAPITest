//
//  APIController.swift
//  SeatGeekAPITest
//
//  Created by Michael Brown on 4/19/21.
//

import Foundation

struct Results: Codable {
    var events: [Event]
}


struct Event: Codable, Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        if lhs.shortTitle == rhs.shortTitle {
            return true
        } else {
            return false
        }
    }
    
    var type: String
    var venue: Venue
    var shortTitle: String
    var timeAndDate: String
    var performers: [Performer]
    var favorited: Bool?
    
    enum CodingKeys: String, CodingKey {
        case type
        case venue
        case shortTitle = "short_title"
        case timeAndDate = "datetime_utc"
        case performers = "performers"
    }
}


struct Venue: Codable {
    var state: String
    var displayLocation: String
    enum CodingKeys: String, CodingKey {
        case state = "state"
        case displayLocation = "display_location"
    }
}
struct Performer: Codable {
    var image: String
    var id: Int
    
}
