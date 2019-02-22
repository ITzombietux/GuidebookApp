//
//  PlacesViewController.swift
//  Guidebook
//
//  Created by Christopher Ching on 2018-06-22.
//  Copyright © 2018 Christopher Ching. All rights reserved.
//

import UIKit
import RealmSwift

class PlacesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var places:Results<Place>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Grab the places from the bundled realm file
        places = PlaceService.getPlaces()
        
        // Configure the tableView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard places != nil && tableView.indexPathForSelectedRow != nil else {
            return
        }
        
        let detailVC = segue.destination as? DetailViewController
        
        if let detailVC = detailVC {
            
            // Set the place for the detail view Controller
            detailVC.place = places![tableView.indexPathForSelectedRow!.row]
        }
    }
}

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places != nil ? places!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.placeCellId, for: indexPath) as! PlaceCell
        
        // Get the place
        let p = places![indexPath.row]
        
        // Set the cell
        cell.showPlace(p)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Trigger the segue to the detail view controller
        performSegue(withIdentifier: Constants.Storyboard.detailSegue, sender: self)
        
    }
}
