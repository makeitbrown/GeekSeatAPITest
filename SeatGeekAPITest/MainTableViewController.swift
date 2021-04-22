//
//  MainTableViewController.swift
//  SeatGeekAPITest
//
//  Created by Michael Brown on 4/19/21.
//

import UIKit

class MainTableViewController: UITableViewController {
    
//    MARK:- SearchBar
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func favoritesButtonTapped(_ sender: Any) {
        listOfEvents = FavoritesController.shared.favoritedEvents
        tableView.reloadData()
    }
    
    var listOfEvents = [Event]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
       listOfEvents = FavoritesController.shared.loadFromFile()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfEvents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let event = listOfEvents[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell", for: indexPath) as! MainTableViewCell
        
        cell.updateCellUI(currentSearch: event)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        check for the identifier
        guard segue.identifier == "MainToDetail" else { return }
        //        pull out the DetailViewController
        guard let detailVC = segue.destination as? ViewController else { return }
        //        get the selected Event
        let indexPath = tableView.indexPathForSelectedRow!
        let currentEvent = listOfEvents[indexPath.row]
        //        assign selected currentEvent to detail vc
        detailVC.currentEvent = currentEvent
    }
}

// MARK:- Extensions

extension MainTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        let eventRequest = EventRequest(searchedEvent: searchBarText)
        eventRequest.SearchEvent { [ weak self ] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let events):
                self?.listOfEvents = events
            }
        }
    }
}
