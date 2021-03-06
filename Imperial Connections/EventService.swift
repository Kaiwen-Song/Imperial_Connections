//
//  EventService.swift
//  Imperial Connections
//
//  Created by Jinman Park on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation
import CoreData

class EventService {
    
    var setting: Settings!
    var data: NSArray = []
    var events = [Event]()
    
    init () {
        self.setting = Settings()
    }
    
    func getEvent () -> [Event] {
        return request(setting.queryalleventsurl)
    }
    
    func request (url:String) -> [Event]{
        var nsURL = NSURL(string: url)
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        //println(callback)
        /*let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL!) {
            (data,response,error) in
            var error:NSError?
            var response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
            callback(response)
        }*/
        //task.resume()
        return parsingJSON((try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSArray)
    }
    
    func upload(newEvent: Event) {
        var url: NSString = setting.uploadurl + "?event_id=\(newEvent.eventID)&owner=\(newEvent.owner.login)&title=\(newEvent.title)&category=\(newEvent.category.rawValue)&description=\(newEvent.description)"
        url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
        let data = NSData(contentsOfURL: NSURL(string: url as String)!)
        var result = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
    }
    
    //Parsing the fetched json data from url and append them to the list of events to be shown on collection view
    func parsingJSON(eventss: NSArray) -> [Event]{
        //events.removeAll(keepCapacity: false)
        var events = [Event]()
        for event in eventss {
            let id = Int((event["event_id"]! as! String))!
            let owner = event["owner"]! as! String
            let title = event["title"]! as! String
            let cate = event["categories"] as! String
            var category = Category(rawValue: cate)
            let description = event["content"] as! String
            let date = event["event_date"] as! String
            let event = Event(eventID: id, owner: User(login: owner), title: title, description: description, category: Category.Recommended, date:date)
            events.append(event)
        }
        return events
    }
    
}