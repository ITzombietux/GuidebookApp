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
    
    var locationManager:CLLocationManager?
    var lastKnowLocation:CLLocation?
    
    var place: Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show the blue dot for the user if the location is known
        mapView.showsUserLocation = true
        
        // Create and configure the location manager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
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
    
    func showGeolocationError() {
        
        // Create the error alert
        let alert = UIAlertController(title: "Geolocation failed", message: "Location services are turned off or this app doesn't have permission to geolocate", preferredStyle: .alert)
        
        // Create the settings button
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alert) in
            
            let url = URL(string: UIApplication.openSettingsURLString)
            
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(settingsAction)
        
        // Create the cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        // Show the alert
       present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        
        // Dismiss the map view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func locateTapped(_ sender: UIButton) {
        
        if CLLocationManager.locationServicesEnabled() {
            
            // check the authorization status
            let status = CLLocationManager.authorizationStatus()
            
            if status == .denied || status == .restricted {
                
                // Show the error popup
                showGeolocationError()
                
            } else if status == .authorizedWhenInUse || status == .authorizedAlways {
                
                // Start geolocating the user
                locationManager?.startUpdatingLocation()
                
                // Center the map around the last known location
                if let lastKnownLocation = lastKnowLocation {
                    mapView.setCenter(lastKnownLocation.coordinate, animated: true)
                }
                
            } else if status == .notDetermined {
                
                // Ask the user foe permission
                locationManager?.requestAlwaysAuthorization()
            }
            
        } else {
            
            // Location services turned off
            showGeolocationError()
        }
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

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        if let location = location {
            
            // Center the map around this location, only if it's the first time location the user
            if lastKnowLocation == nil {
            mapView.setCenter(location.coordinate, animated: true)
            }
            
            lastKnowLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .denied || status == .restricted {
            
            // User chose don't allow
            showGeolocationError()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            
            // Start locating the user
            locationManager?.startUpdatingLocation()
            
        }
    }
}
