//
//  Chatroom.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation
public class Chatroom{
    
    var messages = [Message]()
    let sender:User
    let owner:User
    let event:Event
    var chatroomID:Int!
    
    init(event:Event, sender:User){
        self.event = event
        self.owner = event.owner
        self.sender = sender
    }
    
    init(event:Event, sender: User, chatroomID: Int) {
        self.event = event
        self.owner = event.owner
        self.sender = sender
        self.chatroomID = chatroomID
    }
    
    func get_chatroom_ID() -> Int{
        var url:NSString = "http://www.doc.ic.ac.uk/project/2014/271/g1427123/web/createChatroomID.php?event_id=\(event.eventID)"
        var data = NSData(contentsOfURL: NSURL(string: url as String)!)
        var result = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
        let resultint = result.stringByReplacingOccurrencesOfString("\n", withString:"").toInt()!
        self.chatroomID = resultint
        return resultint
    }
    
    func get_messages() -> [Message] {
        messages = BackendServices.SingleInstance.get_messages(self)
        return messages
    }
}