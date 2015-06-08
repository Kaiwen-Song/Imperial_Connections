//
//  BackendServices.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 06/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation

class BackendServices{
    
    let setting = Settings()
    
    //private let backend = BackendServices()
    
    
    //returns the singleton instance, used as the entry point to the service
    /*func getInstance()->BackendServices{
        return backend
    }*/
    
    //returns an array of events that the user is watching
    func watched_events_for_user(user:User)->[Event]{
        var url = setting.getwatcheventsurl + "?u_id=\(user.login)"
        var nsURL = NSURL(string: url)
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        return parseJSONforEvents(NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray)
    }
    
    //returns an array of events that the user has posted
    func posted_events_for_user(user:User) -> [Event]{
        var url = setting.getpostedeventsulr + "?u_id=\(user.login)"
        var nsURL = NSURL(string: url)
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        return parseJSONforEvents(NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray)
    }
    
    
    //returns an array of subscriptions currently of the user
    func user_subscriptions(user:User) -> [Category]{
        var url = setting.getsubscriptionsurl + "?u_id=\(user.login)"
        var nsURL = NSURL(string:url)
        var data = NSData(contentsOfURL:NSURL(string:url)!)
        var array = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray
        var result = [Category]()
        for item in array{
            var category = Category(rawValue: (item["category"] as! String))
            result.append(category!)
        }
        return result
    }
    
    //returns an array of chatrooms associated with the events
    func get_chatrooms(event:Event) -> [Chatroom]{
        return [Chatroom]()
    }
    
    //returns an array of messages that are within the specified chatroom
    func get_messages(chatroom:Chatroom) -> [Message]{
        return [Message]()
    }
    
    //posts the event to the database, owner of the event is accessed through the event object
    func post_event(event:Event){
        var url: NSString = setting.uploadurl + "?event_id=\(event.eventID)&owner=\(event.owner.login)&title=\(event.title)&category=\(event.category.rawValue)&description=\(event.description)"
        upload(url)
        add_to_my_events(event.owner, event: event)
    }
    
    
    
    //removes the event from the events, watched_events and my events table
    func remove_event(event:Event){
        var url:NSString = setting.removeeventurl + "?event_id=\(event.eventID)"
        upload(url)
    }
    
    func remove_from_watched_events(user:User, event:Event){
        var url:NSString = setting.removefromwatchedeventurl + "?u_id=\(user.login)&event_id=\(event.eventID)"
        upload(url)
    }
    
    private func remove_from_my_events(user:User, event:Event){
        
    }
    
    //sends a message to the chatroom, sender accessed throught the message object
    func send_message(message:Message, chatroom:Chatroom){
      
    }
    
    
    //add the event to the list of events the user is currently watching
    func add_to_watched_events(user:User, event:Event){
        var url:NSString = setting.savewatcheventurl + "?event_id =\(event.eventID)&u_id=\(user.login)"
        upload(url)
    }

    //saves the event to the list of events that the user has posted
    private func add_to_my_events(user:User, event:Event){
        var url:NSString = setting.savetomyeventsurl + "?event_id =\(event.eventID)&u_id=\(user.login)"
        upload(url)
    }
    
    
    //saves a new chatroom under the event in the database
    func create_new_chatroom(event:Event, chatroom:Chatroom){
        
    }
    
    func get_user(id: String, password: String) -> Bool {
        
        var url: NSString = setting.loginurl + "?username=\(id)&password=\(password)"
        url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
        var data = NSData(contentsOfURL: NSURL(string: url as String)!)
        var result = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
        if (result == "success") {
            return true
        } else {
            return false
        }

    }
    
    
    
}