//
//  BackendServices.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 06/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation

class BackendServices{
    
    var settings = Settings()
    
    
    private let backend = BackendServices()
    
    
    
    func getInstance()->BackendServices{
        return backend
    }
    
    /*
    
    func watched_events_for_user(user:User)->[Event]{
        
    }
    
    func saved_events_for_user(user:User) -> [Event]{
        
    }
    
    func user_subscriptions(user:User) -> [Category]{
        
    }
    
    func get_chatrooms(event:Event) -> [Chatroom]{
        
    }
    
    func get_messages(chatroom:Chatroom) -> [Message]{
        
    }
    
    func post_event(user:User, event:Event){
        
    }
    
    func send_message(message:Message, chatroom:Chatroom){
        
    }
    
    func add_to_watched_events(user:User, event:Event){
        
    }
    
    func add_to_saved_events(user:User, event:Event){
        
    }
    
    func create_new_chatroom(event:Event, chatroom:Chatroom){
        
    }
    

    */
    
    
}