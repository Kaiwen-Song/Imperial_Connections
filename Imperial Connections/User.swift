//
//  User.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 26/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation
public class User{
    
    let login:String
    var subscriptions = [Bool](count:Category.allCategories.count, repeatedValue:false)
    var watched_events = [Int:Event]()
    var posted_events = [Int:Event]()
    
    init(login:String){
        self.login = login
    }
    
    func postEvent(title:String, description:String, category:Category){
      /*contacting the server returns a unique event ID, which is used to create an event 
        locally, and it can be accessed offline
        */
        
      //var ID = server.postEvent(title, description, category)
      //var event:Event = new Event(ID, self, title, description, category)
      //posted_events[ID]= event;
        
    }
    
    
    func removePostedEvent(event:Event){
       // posted_events.removeValueForKey(event.getID())
        // posted_events[event.getID()] = nil
    }
    
    func removeWatchedEvent(event:Event){
       // watched_events.removeValueForKey(event.getID())
    }
    
    func watchEvent(event:Event){
       // watched_events[event.getID()] = event
    }
    
    
}