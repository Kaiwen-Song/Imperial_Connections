//
//  ChatViewController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class ChatViewController: KeyboardViewController, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate {

    //@IBOutlet weak var TextField: UITextView!
    
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var MessageTable: UITableView!
    @IBOutlet weak var SendButton: UIButton!
    var user:User!
    var event:Event!
    var chatroom:Chatroom!
    var timer: NSTimer!
    let dateFormatter = NSDateFormatter()
    var time1: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MessageTable.dataSource = self
        MessageTable.delegate = self
        // Do any additional setup after loading the view.
        chatroom.get_messages()
        if(chatroom.sender.login == user.login){
          self.navigationItem.title = chatroom.owner.login
        } else {
          self.navigationItem.title = chatroom.sender.login
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateMessages", userInfo: nil, repeats: true)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        time1 = dateFormatter.stringFromDate(NSDate())
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (self.activeTextField != nil)
        {
            self.activeTextField?.resignFirstResponder()
            self.activeTextField = nil
        }
    }
    
    
    func updateMessages() {
        let str = dateFormatter.stringFromDate(NSDate())
        if (chatroom.sender.login == user.login) {
            chatroom.update_messages(time1, sender_id: chatroom.owner.login)
        } else {
            chatroom.update_messages(time1, sender_id: chatroom.sender.login)
        }
        
        print(time1 + str)
        time1 = str
        MessageTable.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatroom.messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let chatMessage = chatroom.messages[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageCell
        cell.TimeLabel.hidden = true
        cell.SenderLabel.hidden = true
        if(chatMessage.user.login == user.login) {
            cell.MessageLabel.textAlignment = .Right
            cell.backgroundColor = UIColor.clearColor()
        } 
        cell.MessageLabel.text = chatMessage.message
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let chatMessage = chatroom.messages[indexPath.row]
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MessageCell
        var sender:String!
        if(chatMessage.user.login == user.login) {
            sender = "You"
        } else {
            sender = chatMessage.user.login
        }
        
        var date = chatMessage.date
        let startindex = date.startIndex.advancedBy(2)
        let endindex = date.startIndex.advancedBy(19)
        date = date.substringToIndex(endindex)
        date = date.substringFromIndex(startindex)
        cell.TimeLabel.text = "Sent at: " + date
        
        cell.SenderLabel.text = "Sent by: " + sender
        
        cell.TimeLabel.hidden = false
        cell.SenderLabel.hidden = false
    }
    
    @IBAction func SendButtonPressed(sender: UIButton) {
        let message = TextField.text
        if message != nil {
            let new_message = Message(message: message!, user: self.user, messageID: 1, date: "\(NSDate())")
            chatroom.messages.append(new_message)
            // println(NSDateFormatter().stringFromDate(new_message.date))
            /*TODO
              update the server and store in core data
            */
            BackendServices.SingleInstance.send_message(new_message, chatroom: chatroom)
            MessageTable.reloadData()
            TextField.text = ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
