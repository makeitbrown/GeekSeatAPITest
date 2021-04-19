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

struct Event: Codable {
    var type: String
    var id: Int
    var venue: [Venue]
}

struct Venue: Codable {
    var state: String
    var name_v2: String
    var postal_code: String
    var name: String
    var address: String
    var country: String
    var has_upcoming_events: Bool
    var num_upcoming_events: Int
    var city: String
    var extended_address: String
    var display_location: String
    var performers: Performers
    var short_title: String
    var datetime_utc: String
}

struct Performers: Codable {
    var image: String
}

