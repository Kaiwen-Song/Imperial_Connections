//
//  MyEventsController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 30/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit
import CoreData

class MyEventsController: UICollectionViewController {

    @IBOutlet weak var SegControl: UISegmentedControl!
    
    var user:User!
    var events:[Event]!
    var eventCoreDataService = EventCoreDataService()
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events = BackendServices.SingleInstance.posted_events_for_user(user)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        //let event = Event(eventID: 1, owner: User(login: "jefffer"), title: "test", description: "test event", category: Category.Photography)
        

        //events.append(event)
        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        /*service.getEvent {
            (response) in
            self.load(response["events"]! as! NSArray)
        }*/
        
        
        // Functions loading from database (Enable to load from online database)
        // service = EventService()
        // events = events + service.getEvent()
        
        // Functions loading from Core Data
        //loadFromCoreData()
        
        /*  TODO:
        load initial user events from coredata 
        */
        
        self.collectionView?.reloadData()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function doing initial loading from existing core data rather than fetching from network database
    func loadFromCoreData() {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        //events = events + eventCoreDataService.fetchEvent(context)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return events.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EventCell", forIndexPath: indexPath) as! EventCell
        cell.event = events[indexPath.row]
        cell.update()
        // Configure the cell
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject!){
        if segue.identifier == "MyEventToEventDetail" {
            var dst = segue.destinationViewController as! EventDetailController
            dst.user = self.user
            let src = sender as! EventCell
            dst.event = src.event
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    @IBAction func SegClicked(sender: UISegmentedControl) {
        switch SegControl.selectedSegmentIndex{
        case 0: events = BackendServices.SingleInstance.posted_events_for_user(user);
            self.collectionView?.reloadData()
        case 1: events = BackendServices.SingleInstance.watched_events_for_user(user);
            self.collectionView?.reloadData()
        default:break
        }
        self.collectionView?.reloadData()
    }
    
    func collectionView(collectionView:UICollectionView,
        layout collectionViewLayOut: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    @IBAction func unwindToSegue(segue:UIStoryboardSegue) {}

}
