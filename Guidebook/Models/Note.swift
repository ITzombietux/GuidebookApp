//
//  Note.swift
//  Guidebook
//
//  Created by Christopher Ching on 2018-06-22.
//  Copyright © 2018 Christopher Ching. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    
    @objc dynamic var placeId:String?
    @objc dynamic var date:String?
    @objc dynamic var text:String?
    
}
