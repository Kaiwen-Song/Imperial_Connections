//
//  MessageTableController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class ChatroomTableController: UITableViewController {

    var event:Event!
    //user always depicks who is currently using the application
    var user:User!
    var keys:[String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\n\n\n\n\n\n\n" + event.title + "\n\n\n\n\n")
        
        //index into all the chatrooms of the event
        let keys:[String] = [String](event.chatrooms.keys)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return event.chatrooms.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageTableCell", forIndexPath: indexPath) as! ChatroomTableCell
        cell.chatroom = self.event.chatrooms[keys[indexPath.row]]
        cell.updateCell()
        return cell
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChatroomToMessage"{
            let dst = (segue.destinationViewController as! UINavigationController).topViewController as! ChatViewController
            dst.user = self.user
            dst.event = self.event
        
            dst.chatroom = BackendServices.SingleInstance.get_chatrooms(event)[user.login]
            print("Here")
            
            /*if event.chatrooms[user.login] != nil {
                let chatroom = event.chatrooms[user.login]
                dst.chatroom = chatroom
            } else {
                event.chatrooms[user.login] = Chatroom(event: self.event, sender: self.user)
            }*/
        }
        
    }
    
    @IBAction func unwindEventDetail(segue:UIStoryboardSegue) {}
}
