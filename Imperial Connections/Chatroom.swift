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
    init(event:Event, sender:User, owner:User){
        self.event = event
        self.owner = owner
        self.sender = sender
    }
}