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
        let url:NSString = "http://www.doc.ic.ac.uk/project/2014/271/g1427123/web/createChatroomID.php?event_id=\(event.eventID)"
        let data = NSData(contentsOfURL: NSURL(string: url as String)!)
        let result = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
        let resultint = Int(result.stringByReplacingOccurrencesOfString("\n", withString:""))!
        self.chatroomID = resultint
        return resultint
    }
    
    func get_messages() -> [Message] {
        messages = BackendServices.SingleInstance.get_messages(self, time: "", sender_id: "")
        return messages
    }
    
    func update_messages(time: String, sender_id: String) -> [Message] {
        messages += BackendServices.SingleInstance.get_messages(self, time: time, sender_id: sender_id)
        return messages
    }
    
}