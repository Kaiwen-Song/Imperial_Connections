//
//  Event.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 26/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation
import CoreData

public class Event{
    
    var eventID:Int
    var description:String
    var title:String
    var category:Category
    var owner:User
    var chatrooms = [String:Chatroom]()
    var date:String
    
    
    init(eventID:Int, owner:User, title:String, description:String, category:Category){
        self.eventID = eventID
        self.owner = owner
        self.title = title
        self.description = description
        self.category = category
        self.date = NSDateFormatter().stringFromDate(NSDate())
        println(date)
    }
 
    
    func getID()->Int{
      return eventID
    }
    
}