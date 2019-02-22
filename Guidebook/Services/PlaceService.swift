//
//  PlaceService.swift
//  Guidebook
//
//  Created by Christopher Ching on 2018-06-23.
//  Copyright © 2018 Christopher Ching. All rights reserved.
//

import Foundation
import RealmSwift

class PlaceService {
    
    static func getPlaces() -> Results<Place> {
        
        // Get a reference to the place.realm file
        let realm = try! Realm(configuration: Constants.RealmConfig.placesConfig)
        
        // Get the places and return them
        return realm.objects(Place.self)
    }
    
}
