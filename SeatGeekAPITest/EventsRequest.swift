//
//  EventsRequest.swift
//  SeatGeekAPITest
//
//  Created by Michael Brown on 4/19/21.
//

import Foundation

enum EventsError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct EventRequest {
    let resourceURL: URL
    let API_KEY = "MjE3NTIzMzd8MTYxODg0OTUyOC4yODQ1MTEz"
    
    init(searchedEvent: String) {
        
        let resourceString = "https://api.seatgeek.com/2/events?q=\(searchedEvent)&client_id=\(API_KEY)"
        print(resourceString)
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func SearchEvent(completion: @escaping(Result<[Venue], EventsError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let eventsResponse = try decoder.decode(Event.self, from: jsonData)
                let eventDetails = eventsResponse.venue
                completion(.success(eventDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
            
        }
        dataTask.resume()
    }
}

var favoriteEvents: [Results] = []
