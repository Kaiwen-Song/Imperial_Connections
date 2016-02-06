//
//  EventCoreDataService.swift
//  Imperial Connections
//
//  Created by Jinman Park on 05/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation
import CoreData

class EventCoreDataService {
    
    
    var events = [Event]()
    
    func saveEvent(context: NSManagedObjectContext, newEvent: Event) {
        let ent = NSEntityDescription.entityForName("EventModel", inManagedObjectContext: context)
        
        // Create entity for the core data model.
        let event = EventModel(entity: ent!, insertIntoManagedObjectContext: context)
        event.title = newEvent.title
        event.eventID = "\(newEvent.eventID)"
        event.descriptions = newEvent.description
        event.date = newEvent.date
        event.owner = newEvent.owner.login
        event.category = newEvent.category.rawValue
        
        do {
            try context.save()
        } catch _ {
        }
        
        print(event)
        print("Object saved!")
        
    }
    
    
    func fetchEvent(context: NSManagedObjectContext, predicate: String) -> [Event]{
        let request = NSFetchRequest(entityName: "EventModel")
        request.returnsObjectsAsFaults = false;
        if (predicate == "") {
            request.predicate = NSPredicate(format: "category = %@", predicate)
        }
        let results: NSArray = try! context.executeFetchRequest(request)
        
        events.removeAll(keepCapacity: false)
        for result in results {
            let res = result as! EventModel
            let event = Event(eventID: Int(res.eventID)!, owner: User(login: res.owner), title: res.title, description: res.descriptions, category: Category(rawValue: res.category)!, date:res.date)
            events.append(event)
        }
        return events
    }
    
    func deleteAllEntities(context: NSManagedObjectContext) {
        var request = NSFetchRequest(entityName: "EventModel")
        request.returnsObjectsAsFaults = false
        var results: NSArray = try! context.executeFetchRequest(request)
        for ob in results {
            context.deleteObject(ob as! NSManagedObject)
        }
        
        do {
            try context.save()
        } catch _ {
        }

        request = NSFetchRequest(entityName: "UserModel")
        request.returnsObjectsAsFaults = false
        results = try! context.executeFetchRequest(request)
        for ob in results {
            context.deleteObject(ob as! NSManagedObject)
        }
        do {
            try context.save()
        } catch _ {
        }

    }
    
    
}
