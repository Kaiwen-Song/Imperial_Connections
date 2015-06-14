//
//  TestHomeScreenController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class TestHomeScreenController: UIViewController,UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var CategoryList: UITableView!
    @IBOutlet weak var EventCollection: UICollectionView!
    var user:User!
    let backend = BackendServices.SingleInstance
    var subscriptions:[Category]!
    var events: [Event] = [Event]()
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        CategoryList.dataSource = self
        CategoryList.delegate = self
        EventCollection.dataSource = self
        EventCollection.delegate = self
        CategoryList.allowsMultipleSelection = false
        CategoryList.allowsMultipleSelectionDuringEditing = false
        subscriptions = backend.bitarray_to_subscription(backend.new_get_user_subscriptions(user))
        subscriptions.append(Category.Recommended)
        subscriptions.reverse()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:CategoryCell = tableView.dequeueReusableCellWithIdentifier("CategoryTableCell", forIndexPath: indexPath) as! CategoryCell
        cell.setCategory(subscriptions[indexPath.row])
        events = cell.events
            
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return subscriptions.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let newCategory = subscriptions[indexPath.row]
        // Duplicate
        var cell:CategoryCell = tableView.cellForRowAtIndexPath(indexPath) as! CategoryCell
        cell.setCategory(subscriptions[indexPath.row])
        events = cell.events
        EventCollection.reloadData()

    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
            return events.count
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EventCell", forIndexPath: indexPath) as! EventCell
        cell.event = events[indexPath.row]
        cell.update()
        // Configure the cell
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject!){
        if segue.identifier == "HomeToEventDetail" {
            var dst = segue.destinationViewController as! EventDetailController
            dst.user = self.user
            let src = sender as! EventCell
            dst.event = src.event
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

    func collectionView(collectionView:UICollectionView,
        layout collectionViewLayOut: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    @IBAction func unwindToSegue(segue:UIStoryboardSegue) {}
}
