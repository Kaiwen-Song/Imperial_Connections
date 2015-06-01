//
//  EventService.swift
//  Imperial Connections
//
//  Created by Jinman Park on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation

class EventService {
    
    var setting: Settings!
    var data: NSArray = []
    
    init () {
        self.setting = Settings()
    }
    
    func getEvent () -> NSArray {
        return request(setting.fetchurl)
    }
    
    func request (url:String) -> NSArray {
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
        return NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray
    }
    
}