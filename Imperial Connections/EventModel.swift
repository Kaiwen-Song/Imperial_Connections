//
//  Events.swift
//  Imperial Connections
//
//  Created by Jinman Park on 05/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation
import CoreData

class Events: NSManagedObject {

    @NSManaged var category: String
    @NSManaged var date: String
    @NSManaged var descriptions: String
    @NSManaged var eventID: String
    @NSManaged var owner: String
    @NSManaged var title: String
    
    class func createInManageObjectContext(moc: NSManagedObjectContext, event: Event) -> Events {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Model", inManagedObjectContext: moc) as! Events
        
        newItem.category = event.category.rawValue
        newItem.date = event.date
        newItem.descriptions = event.description
        newItem.eventID = "\(event.eventID)"
        newItem.owner = event.owner.login
        newItem.title = event.title
        
        return newItem
    }

}
