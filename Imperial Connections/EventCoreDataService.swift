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
        var ent = NSEntityDescription.entityForName("EventModel", inManagedObjectContext: context)
        
        // Create entity for the core data model.
        var event = EventModel(entity: ent!, insertIntoManagedObjectContext: context)
        event.title = newEvent.title
        event.eventID = "\(newEvent.eventID)"
        event.descriptions = newEvent.description
        event.date = newEvent.date
        event.owner = newEvent.owner.login
        event.category = newEvent.category.rawValue
        
        context.save(nil)
        
        println(event)
        println("Object saved!")
        
    }
    
    
    func fetchEvent(context: NSManagedObjectContext, predicate: String) -> [Event]{
        let request = NSFetchRequest(entityName: "EventModel")
        request.returnsObjectsAsFaults = false;
        if (predicate == "") {
            request.predicate = NSPredicate(format: "category = %@", predicate)
        }
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        
        events.removeAll(keepCapacity: false)
        for result in results {
            var res = result as! EventModel
            var event = Event(eventID: res.eventID.toInt()!, owner: User(login: res.owner), title: res.title, description: res.descriptions, category: Category(rawValue: res.category)!)
            events.append(event)
        }
        return events
    }
    
    func deleteAllEntities(context: NSManagedObjectContext) {
        let request = NSFetchRequest(entityName: "EventModel")
        request.returnsObjectsAsFaults = false;
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        for ob in results {
            context.deleteObject(ob as! NSManagedObject)
        }
        context.save(nil)
       // println(fetchEvent(context, predicate: "").count)
    }
    
    
}
