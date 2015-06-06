//
//  Message.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation
public class Message{
    
    let message:String
    let user:User
    let date:NSDate
    let messageID:Int
    
    init(message:String, user:User, messageID:Int){
        self.message = message
        self.user = user
        self.date = NSDate()
        self.messageID = messageID
    }
    
}