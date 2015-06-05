//
//  Events.swift
//  Imperial Connections
//
//  Created by Jinman Park on 05/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit
import CoreData

// Custome core data object
@objc(EventModel)
class EventModel: NSManagedObject {

    @NSManaged var category: String
    @NSManaged var date: String
    @NSManaged var descriptions: String
    @NSManaged var eventID: String
    @NSManaged var owner: String
    @NSManaged var title: String
    

}
