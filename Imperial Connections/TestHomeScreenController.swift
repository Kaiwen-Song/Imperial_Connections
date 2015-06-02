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
    
    var subscriptions = [Category]()
    var events:[Event] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions.append(Category.Recommended)
        subscriptions.append(Category.Tech)
        CategoryList.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryTableCell", forIndexPath: indexPath) as! CategoryCell
        cell.setCategory(subscriptions[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return subscriptions.count
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
            return events.count
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EventCell", forIndexPath: indexPath) as! EventCell
        cell.event = events[indexPath.row]
        cell.update()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //retrieves the new list of events to display 
        let newCategory = subscriptions[indexPath.row]
        EventCollection.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwindToSegue(segue:UIStoryboardSegue) {}
}
