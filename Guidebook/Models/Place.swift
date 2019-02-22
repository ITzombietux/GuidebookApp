//
//  Place.swift
//  Guidebook
//
//  Created by Christopher Ching on 2018-06-22.
//  Copyright © 2018 Christopher Ching. All rights reserved.
//

import Foundation
import RealmSwift

class Place: Object {
    
    @objc dynamic var placeId:String?
    @objc dynamic var name:String?
    @objc dynamic var address:String?
    @objc dynamic var summary:String?
    var lat:Double?
    var long:Double?
    
}
