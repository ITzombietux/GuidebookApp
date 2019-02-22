//
//  MapViewController.swift
//  Guidebook
//
//  Created by Christopher Ching on 2018-06-22.
//  Copyright © 2018 Christopher Ching. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var place: Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check for a place and plot the pin
        if place != nil {
            plotPin(place!)
        }

    }
    
    func plotPin(_ p: Place) {
        
        // Create the pin
        let pin = MKPointAnnotation()
        
        pin.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(p.lat), longitude: CLLocationDegrees(p.long))
        pin.title = p.name!
        
        // Add the pin
        mapView.addAnnotation(pin)
        
        // Center the map around the pin
        mapView.showAnnotations([pin], animated: true)
        
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        
        // Dismiss the map view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func locateTapped(_ sender: UIButton) {
    }
    
    @IBAction func routeTapped(_ sender: UIButton) {
        
        guard place != nil && place!.address != nil else {
            return
        }
        
        // Replace all spaces with +
        let newAddress = place!.address!.replacingOccurrences(of: " ", with: "+")
        
        
        let url = URL(string: "http://maps.apple.com/?address=" + newAddress)
        
        if let url = url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

