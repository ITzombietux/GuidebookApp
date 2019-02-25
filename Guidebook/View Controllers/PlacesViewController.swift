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
    var faves: Results<Place>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        // Grab the places from the bundled realm file
        places = PlaceService.getPlaces()
        
        // Grab the faves from the fefault realm file
        faves = FaveService.getFavePlaces()
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if faves!.count > 0 {
            
            // There are some faves saved, so do 2 sections
            return 2
        } else {
            
            // Otherwise just do 1 section for all places
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.numberOfSections > 1 && section == 0 {
            
            // There are 2 sections, and it's asking about the 1st section
            return faves != nil ? faves!.count : 0
        } else {
            
            // There is only 1 section
            return places != nil ? places!.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.placeCellId, for: indexPath) as! PlaceCell
        
        // Get the place
        var p: Place?
        
        if tableView.numberOfSections > 1 && indexPath.section == 0 {
            
            // There ate 2 sections, it's asking about the 1st section
            p = faves![indexPath.row]
        } else {
            
            // There's only 1 section
            p = places![indexPath.row]
        }
        
        // Set the cell
        cell.showPlace(p!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Trigger the segue to the detail view controller
        performSegue(withIdentifier: Constants.Storyboard.detailSegue, sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Get the place
        var p: Place?
        
        if tableView.numberOfSections > 1 && indexPath.section == 0 {
            p = faves![indexPath.row]
        } else {
            p = places![indexPath.row]
        }
        
        // Decide what the action title should be
        var actionTitle = ""
        
        if tableView.numberOfSections > 1 && indexPath.section == 0 {
            
            // This user is sliding over a place in the fave section
            actionTitle = "Unfave"
        } else if faves!.index(of: p!) != nil {
            
            // This place is in faves list
            actionTitle = "Unfave"
        } else {
            actionTitle = "Fave"
        }
        
        let rowAction = UITableViewRowAction(style: .normal, title: actionTitle) { (action, indexPath) in
            
            // Toggle the fave
            FaveService.toggleFave(p!.placeId!)
            
            // Get the now list of faves
            self.faves = FaveService.getFavePlaces()
            
            // Reload the tableview
            self.tableView.reloadData()
        }
        
        return [rowAction]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Creating a UIView for the section header
        let view = UIView()
        
        // Create a label
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and add the auto layout constraints for the label inthe view
        let leftLabelConstraint = NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 10)
        
        let topLabelConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 10)
        
        // Add the label into the view
        view.addSubview(label)
        
        // Add the constraints to the view
        view.addConstraints([leftLabelConstraint, topLabelConstraint])
        
        // Set the label text
        if tableView.numberOfSections > 1 && section == 0 {
            label.text = "Faves"
        } else {
            label.text = "All Places"
        }
        
        // Return the view
        return view
    }
}
