//
//  EventDetailController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 30/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class EventDetailController: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var WatchButton: UIButton!
    @IBOutlet weak var RemoveButton: UIButton!
    @IBOutlet weak var BackButton: UIBarButtonItem!
    @IBOutlet weak var Message: UIButton!
    @IBOutlet weak var Chatrooms: UIButton!
    var event:Event!
    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       /* if event.owner.login == user.login{
            WatchButton.hidden = true
        } else if (user.watched_events[event.eventID] != nil) {
            WatchButton.titleLabel?.text = "Unwatch"
            RemoveButton.hidden = true
        }*/
        configurateEventDetail()
    }
    
    func configurateEventDetail(){
        TitleLabel.text = event.title
        DescriptionLabel.text = event.description
        CategoryLabel.text = event.category.rawValue
        if(event.owner.login == user.login){
            WatchButton.hidden = true
            Message.hidden = true
        } else {
            RemoveButton.hidden = true
            Chatrooms.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject!){
        if segue.identifier == "EventDetailToChat" {
            var dst = segue.destinationViewController as! ChatViewController
            dst.user = self.user
            dst.event = self.event
            if(event.chatrooms[user.login] != nil) {
                dst.chatroom = event.chatrooms[user.login]
            } else {
               // event.chatrooms[user.login] = Chatroom(event: event, sender: user, owner: event.owner, chatroomID:1)
            }
            
        } else if segue.identifier == "ToChatrooms" {
            var dst = segue.destinationViewController as! ChatroomTableController
            dst.event = self.event
            dst.user = self.user
        }
    }
    
    @IBAction func unwindEventDetail(segue:UIStoryboardSegue) {}
    
    @IBAction func RemoveButtonClicked(sender: UIButton) {
      /*  TODO:
      goes to server and removes the event
      */
    }
    
    @IBAction func WatchButtonclicked(sender: UIButton) {
      /*  TODO:
        goes to the server and change the watched event table
      */
      //self.user.watchEvent[event.eventID] = self.event
    }
}
