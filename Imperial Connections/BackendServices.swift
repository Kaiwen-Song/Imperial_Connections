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
        let url = setting.categorieseventsurl + "?categories=\(category.rawValue)"
        return parseJSONforEvents(url)
    }
    
    //returns an array of events that the user is watching
    func watched_events_for_user(user:User)->[Event]{
        let url = setting.getwatcheventsurl + "?u_id=\(user.login)"
        return parseJSONforEvents(url)
    }
    
    //returns an array of events that the user has posted
    func posted_events_for_user(user:User) -> [Event]{
        let url = setting.getpostedeventsulr + "?u_id=\(user.login)"
        return parseJSONforEvents(url)
    }
    
    /*
    //returns an array of subscriptions currently of the user
    func user_subscriptions(user:User) -> [Category]{
        var url = setting.getsubscriptionsurl + "?u_id=\(user.login)"
        var nsURL = NSURL(string:url)
        var data = NSData(contentsOfURL:NSURL(string:url)!)
        var array = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray
        var result = [Category]()
        if (array == []) {
            return result
        }
        
        for item in array{
            var cate = (item["category"] as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var category = Category(rawValue: cate)
            result.append(category!)
        }
        return result
    }
    */
    func new_get_user_subscriptions(user:User) -> [Bool]{
        let url = setting.getsubscriptionsurl + "?username=\(user.login)"
        var nsURL = NSURL(string:url)
        let data = NSData(contentsOfURL:NSURL(string:url)!)
        let array = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSArray
        var subscriptions = ""
        for sub in array {
            subscriptions = sub["subscriptions"] as! String
        }
        return convert_string_to_bitarray(subscriptions)
    }
    
    //returns an array of chatrooms associated with the events
    func get_chatrooms(event:Event) -> [String:Chatroom]{
        return parseJSONforChatrooms(event.eventID)
    }
    
    //returns an array of messages that are within the specified chatroom
    func get_messages(chatroom:Chatroom, time:String, sender_id:String) -> [Message]{

        return parseJSONforMessages(chatroom.chatroomID, time: time, sender_id:sender_id)
    }
    
    //posts the event to the database, owner of the event is accessed through the event object
    func post_event(event:Event){
        if (event.eventID == nil) {
            event.get_event_ID()
        }
        let url: NSString = setting.uploadurl + "?event_id=\(event.eventID)&owner=\(event.owner.login)&title=\(event.title)&category=\(event.category.rawValue)&description=\(event.description)&event_date=\(event.date)"
        
        upload(url)
    }
    
    //removes the event from the events, watched_events and my events table
    func remove_event(event:Event){
        let url:NSString = setting.removeeventurl + "?event_id=\(event.eventID)"
        upload(url)
    }
    
    func remove_from_watched_events(user:User, event:Event){
        let url:NSString = setting.removefromwatchedeventurl + "?u_id=\(user.login)&event_id=\(event.eventID)"
        upload(url)
    }

    //sends a message to the chatroom, sender accessed throught the message object
    func send_message(message:Message, chatroom:Chatroom){
        let url:NSString = setting.sendmessageurl + "?chatroom_id=\(chatroom.chatroomID)&message_id=\(message.messageID)&sender_id=\(message.user.login)&message_content=\(message.message)"
        print(url)
        upload(url)
    }
    
    
    //add the event to the list of events the user is currently watching
    func add_to_watched_events(user:User, event:Event){
        let url:NSString = setting.savewatcheventurl + "?u_id=\(user.login)&event_id=\(event.eventID)"
        upload(url)
    }
    
    func save_subscriptions(user:User){
        let subscriptions = convert_bitarray_to_string(user.subscriptions)
        let url:NSString = setting.savesubscriptionurl + "?username=\(user.login)&subscriptions=\(subscriptions)"
        upload(url)
    }
    
    
    //saves a new chatroom under the event in the database
    func create_new_chatroom(event:Event, chatroom:Chatroom){
        if(chatroom.chatroomID == nil){
            chatroom.get_chatroom_ID()
        }
        let url:NSString = setting.newchatroomurl + "?event_id=\(event.eventID)&event_owner_id=\(event.owner.login)&sender_id=\(chatroom.sender.login)&chatroom_id=\(chatroom.chatroomID)"
        print(url as String)
        upload(url)
    }
    
    func get_event(event_id: Int) -> [Event] {
        let url = setting.geteventurl + "?event_id=\(event_id)"
        return parseJSONforEvents(url)
    }
    
    private func upload(input:NSString)->String{
        let url:NSString = input.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        let data = NSData(contentsOfURL: NSURL(string: url as String)!)
        let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
        return result as! String
    }
        
    func get_user(id: String, password: String) -> Bool {
        
        var url: NSString = setting.loginurl + "?username=\(id)&password=\(password)"
        url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
        let data = NSData(contentsOfURL: NSURL(string: url as String)!)
        let result = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
        if (result == "Success") {
            return true
        } else {
            return false
        }
    }
    

    
    private func parseJSONforEvents(url: String) -> [Event]{
        //events.removeAll(keepCapacity: false)
      /*  if (eventss == nil) {
            return [Event]()
        }*/
        let nsURL = NSURL(string: url)
        let data = NSData(contentsOfURL: nsURL!)
        let eventss = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSArray
        var events = [Event]()
        if (eventss == []) {
            return events
        }
        for event in eventss {
            let id = Int((event["event_id"]! as! String))!
            let owner = (event["owner"]! as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let title = (event["title"]! as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let cate = (event["categories"] as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let category = Category(rawValue: cate)
            let description = (event["content"] as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let date = (event["event_date"] as! String)
            let event = Event(eventID: id, owner: User(login: owner), title: title, description: description, category: category!, date: date)
            events.append(event)
        }
        return events
    }
    
    private func parseJSONforMessages(chatroom_id: Int, time:String, sender_id: String) -> [Message] {
        var url = setting.getmessagesurl + "?chatroom_id=\(chatroom_id)&send_time=\(time)&sender_id=\(sender_id)"
        url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        let nsURL = NSURL(string: url)
        let data = NSData(contentsOfURL: nsURL!)
        let messagess = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSArray
        var messages = [Message]()
        if (messagess == []) {
            return messages
        }
        for message in messagess {
            let id = message["sender_id"] as! String
            let content = message["message_content"] as! String
            let send_time = message["send_time"] as! String
            let message_id = Int((message["message_id"]! as! String))
            let message = Message(message: content, user: User(login: id), messageID: message_id!, date: send_time)
            messages.append(message)
        }
        return messages
    }
    
    private func parseJSONforChatrooms (event_id: Int) -> [String:Chatroom] {
        let nsURL = NSURL(string: setting.getchatroomsurl + "?event_id=\(event_id)")
        let data = NSData(contentsOfURL: nsURL!)
        let chatroomss = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSArray
        var chatrooms = [String:Chatroom]()
        if (chatroomss == []) {
            return chatrooms
        }
        for chatroom in chatroomss {
            let event_id = Int((chatroom["event_id"] as! String))
            let sender_id = chatroom["sender_id"] as! String
            let event_owner_id = chatroom["event_owner_id"] as! String
            let chatroom_id = Int((chatroom["chatroom_id"]! as! String))
            let chatroom = Chatroom(event: (get_event(event_id!))[0], sender: User(login: sender_id), chatroomID: chatroom_id!)
            chatrooms[event_owner_id] = chatroom
        }
      
      //  print(chatrooms.keys.array.count)
        return chatrooms
    }
    
    private func charAsString(str:String, index:Int) -> String {
    return String(Array(str.characters)[index])
    }

    //string is stored at a database, it's a binary array, use when retrieve from server
    func convert_string_to_bitarray(string:String)->[Bool]{
        var result = [Bool]()
        for (var i = 0; i < string.characters.count; ++i){
            if Int(charAsString(string,index: i)) == 1 {
                result.append(true)
            } else {
                result.append(false)
            }
        }

        return result
    }
    
    //user to push to server
    func convert_bitarray_to_string(array:[Bool]) -> String{
        var result = String()
        for(var i = 0; i < array.count; ++i){
            if array[i] {result+="1"} else {result+="0"}
        }
        return result
    }
    
    //user when you actually need tthe category objects
    func subscription_to_bitarray(sub:[Category]) -> [Bool]{
        var result = [Bool](count: Category.CategoryCount, repeatedValue:false)
        for(var i = 0; i < sub.count; ++i){
            let index:Int = Category.allCategories.indexOf(sub[i])!
            result[index] = true
        }
        return result
    }
    
    //saved category, convert back to stored format
    func bitarray_to_subscription(bitarray:[Bool]) -> [Category]{
        for(var i = 0; i<Category.allCategories.count; ++i){
            print(Category.allCategories[i].rawValue)
        }
        var result = [Category]()
        for(var i = 0; i<bitarray.count; ++i){
            if(bitarray[i]){
            result.append(Category.allCategories[i])
            }
        }
        return result
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