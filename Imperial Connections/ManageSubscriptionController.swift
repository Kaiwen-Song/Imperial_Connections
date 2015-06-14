//
//  ManageSubscriptionController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class ManageSubscriptionController: UICollectionViewController {

    //temporary replacement for the user subscription
    var user:User!
    
    let data = Category.allCategories.sorted{$0.rawValue < $1.rawValue}
    var subscription:[Bool]!
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let selectedColour = UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1.0)
    let unselectedColour = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // println(subscription.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // Do any additional setup after loading the view.
        println(subscription)
        self.collectionView?.allowsMultipleSelection  = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*TODO
      back button need to save subscription into core data
    */
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
        return data.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCollectionCell", forIndexPath: indexPath) as! CategoryCollectionCell
        cell.category = data[indexPath.item]
        println(cell.category.rawValue)
        cell.update()
        println(indexPath.item)
        cell.backgroundColor = unselectedColour
        if(subscription[indexPath.item]) {
           cell.selected = true
           self.collectionView?.selectItemAtIndexPath(indexPath, animated: true, scrollPosition:UICollectionViewScrollPosition())
            cell.backgroundColor = selectedColour
        }
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CategoryCollectionCell
        subscription[Category.categoryindex[cell.category]!] = true
        println(cell.category.rawValue + "selected!")
       // cell.backgroundColor = UIColor.redColor()
        cell.backgroundColor = selectedColour
        
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath){
        let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! CategoryCollectionCell
        subscription[Category.categoryindex[cell.category]!] = false
        println(cell.category.rawValue + "unselected!")
       // cell.backgroundColor = UIColor.blueColor()
        cell.backgroundColor = unselectedColour
    }
    
    @IBAction func SaveButtonPressed(sender: UIBarButtonItem) {
        //pop alert box maybe?
        println(BackendServices.SingleInstance.convert_bitarray_to_string(subscription))
        user.subscriptions = subscription
        println(BackendServices.SingleInstance.convert_bitarray_to_string(user.subscriptions))
        BackendServices.SingleInstance.save_subscriptions(user)
        
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
    
    /*
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 200, height: 200)
    }
    
*/
    func collectionView(collectionView:UICollectionView,
        layout collectionViewLayOut: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
}
