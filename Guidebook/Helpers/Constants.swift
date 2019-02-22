//
//  Constants.swift
//  Guidebook
//
//  Created by Christopher Ching on 2018-06-22.
//  Copyright © 2018 Christopher Ching. All rights reserved.
//

import Foundation
import RealmSwift

struct Constants {
    
    struct Storyboard {
        
        static let detailSegue = "toDetail"
        
        static let placeCellId = "PlaceCell"
        static let noteCellId = "NoteCell"
        
        static let notesViewController = "NotesViewController"
        static let composeViewController = "ComposeViewController"
        static let mapViewController = "MapViewController"
    }
    
    struct RealmConfig {
        
        static let placesConfig = Realm.Configuration(fileURL: Bundle.main.url(forResource: "Place", withExtension: "realm"), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: true, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        
    }
}
