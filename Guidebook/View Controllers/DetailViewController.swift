//
//  DetailViewController.swift
//  Guidebook
//
//  Created by Christopher Ching on 2018-06-22.
//  Copyright © 2018 Christopher Ching. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    var place: Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if a place has been set
        if place != nil {
            showPlace(place!)
        }
    }
    
    func showPlace(_ p: Place) {
        
        // Set the labels
        nameLabel.text = p.name
        addressLabel.text = p.address
        summaryLabel.text = p.summary
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notesTapped(_ sender: UIButton) {
        
        let notesVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.notesViewController) as? NotesViewController
        
        if let notesVC = notesVC {
            
            // Set the place property
            notesVC.place = place
            
            // Present the view controller
            present(notesVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func mapTapped(_ sender: UIButton) {
        
        let mapsVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.mapViewController) as? MapViewController
        
        if let mapsVC = mapsVC {
            
            // Set the place propetry
            mapsVC.place = place
            
            // Present the view controller
            present(mapsVC, animated: true, completion: nil)
        }
    }
    
}
