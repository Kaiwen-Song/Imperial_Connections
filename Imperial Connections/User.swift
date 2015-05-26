//
//  User.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 26/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation
public class User:NSObject{
    
    let login:String
    var subscriptions = [Category]()
    var saved_events = [Int:Event]()
    var posted_events = [Int:Event]()
    
    init(login:String){
        self.login = login
    }
    
    
    
}