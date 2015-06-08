//
//  ChatViewController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var MessageTable: UITableView!
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var SendButton: UIButton!
    var user:User!
    var event:Event!
    var chatroom:Chatroom!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MessageTable.dataSource = self
        MessageTable.delegate = self
        // Do any additional setup after loading the view.
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
        let cell =  UITableViewCell()
        cell.textLabel!.text = chatMessage.message
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    
    @IBAction func SendButtonPressed(sender: UIButton) {
        let message = TextField.text
        if message != nil {
            chatroom.messages.append(Message(message: message, user: self.user, messageID: 1))
            /*TODO
              update the server and store in core data
            */
            
            MessageTable.reloadData()
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
