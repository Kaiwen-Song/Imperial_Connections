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
    
    var eventID:Int!
    let description:String
    let title:String
    let category:Category
    let owner:User
    var chatrooms = [String: Chatroom]()
    let date:String
    
    init(eventID:Int, owner:User, title:String, description:String, category:Category, date:String){
        self.eventID = eventID
        self.owner = owner
        self.title = title
        self.description = description
        self.category = category
        self.date = date
    }
 
    init(owner:User, title:String, description:String, category:Category, date:String){
        self.owner = owner
        self.title = title
        self.description = description
        self.category = category
        self.date = date
    }
    
    func get_event_ID() -> Int{
        let url:NSString = "http://www.doc.ic.ac.uk/project/2014/271/g1427123/web/createEventID.php"
        let data = NSData(contentsOfURL: NSURL(string: url as String)!)
        let result = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
        let resultint = Int(result.stringByReplacingOccurrencesOfString("\n", withString:""))!
        eventID = resultint
        return resultint
    }
    
    
}