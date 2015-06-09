//
//  BackendServices.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 06/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation

class BackendServices{
    
    var setting = Settings()
    //returns the singleton instance, used as the entry point to the service
    
    class var SingleInstance:BackendServices{
        struct Singleton {
            static let instance = BackendServices()
        }
        return Singleton.instance
    }
    //private let backend = BackendServices()
    
    
    //returns the singleton instance, used as the entry point to the service
    /*func getInstance()->BackendServices{
        return backend
    }*/
    
    func get_category_event(category: Category) -> [Event] {
        var url = setting.categorieseventsurl + "?categories=\(category.rawValue)"
        var nsURL = NSURL(string: url)
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        return parseJSONforEvents(NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray)
    }
    
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
            var cate = (item["category"] as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var category = Category(rawValue: cate)
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
        if (event.eventID == nil) {
            event.get_event_ID()
        }
        var url: NSString = setting.uploadurl + "?event_id=\(event.eventID)&owner=\(event.owner.login)&title=\(event.title)&category=\(event.category.rawValue)&description=\(event.description)"
        upload(url)
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

    //sends a message to the chatroom, sender accessed throught the message object
    func send_message(message:Message, chatroom:Chatroom){
      
    }
    
    
    //add the event to the list of events the user is currently watching
    func add_to_watched_events(user:User, event:Event){
        var url:NSString = setting.savewatcheventurl + "?u_id=\(user.login)&event_id=\(event.eventID)"
        upload(url)
    }
    
    
    //saves a new chatroom under the event in the database
    func create_new_chatroom(event:Event, chatroom:Chatroom){
        
    }
    
    private func upload(input:NSString)->String{
        var url:NSString = input.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
        var data = NSData(contentsOfURL: NSURL(string: url as String)!)
        var result = NSString(data: data!, encoding: NSUTF8StringEncoding)
        return result as! String
    }
        
    func get_user(id: String, password: String) -> Bool {
        
        var url: NSString = setting.loginurl + "?username=\(id)&password=\(password)"
        url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
        var data = NSData(contentsOfURL: NSURL(string: url as String)!)
        var result = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
        if (result == "Success") {
            return true
        } else {
            return false
        }
    }
    
    private func parseJSONforEvents(eventss: NSArray) -> [Event]{
        //events.removeAll(keepCapacity: false)
      /*  if (eventss == nil) {
            return [Event]()
        }*/
        var events = [Event]()
        for event in eventss {
            var id = (event["event_id"]! as! String).toInt()!
            var owner = (event["owner"]! as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var title = (event["title"]! as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var cate = (event["categories"] as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var category = Category(rawValue: cate)
            var description = (event["content"] as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var event = Event(eventID: id, owner: User(login: owner), title: title, description: description, category: category!)
            events.append(event)
        }
        return events
    }

    /*
    private func request (url:String) -> [Event]{
        var nsURL = NSURL(string: url)
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        //println(callback)
        /*let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL!) {
        (data,response,error) in
        var error:NSError?
        var response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
        callback(response)
        }*/
        //task.resume()
        return parsingJSON(NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray)
    }
    */
    
    
    
    
}