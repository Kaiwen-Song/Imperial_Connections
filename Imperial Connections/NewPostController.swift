//
//  NewPostController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 25/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit
import CoreData

class NewPostController: UIViewController, UIPopoverPresentationControllerDelegate {

    
    @IBOutlet weak var SelectCategoryButton: UIButton!
    @IBOutlet weak var SelectDateButton: UIButton!
    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var DescriptionView: UITextView!
    @IBOutlet weak var CategoryLabel: UILabel!

    var user:User!
    var CategorySelected:Category!
    var Date:String!
    var datesel = false
    var categorysel = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user.login)
        DescriptionView.textColor = UIColor.lightGrayColor()
        DescriptionView.layer.cornerRadius = 10
        DescriptionView.layer.borderWidth = 1
        DescriptionView.layer.borderColor = UIColor.whiteColor().CGColor

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ClearButtonPress(sender: UIButton) {
        /*  TODO:
          pop up a box asking for confirmation
        */
        clear()
    }
    
    func clear() {
        TitleField.text = ""
        DescriptionView.text = ""
        SelectCategoryButton.setTitle("Select Date", forState: .Normal)
        SelectDateButton.setTitle("Select Category", forState: .Normal)
        datesel = false
        Date = nil
        categorysel = false
        CategorySelected = nil
    }
    
    func textViewDidEndEditing(DescriptionView: UITextView) {
        if DescriptionView.text.isEmpty {
            DescriptionView.text = "Insert Description"
            DescriptionView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textViewDidBeginEditing(DescriptionView: UITextView) {
        if DescriptionView.textColor == UIColor.lightGrayColor() {
            DescriptionView.text = nil
            DescriptionView.textColor = UIColor.blackColor()
        }
    }
    

    
    @IBAction func SubmitButtonPress() {
        /*  TODO:
          pop up a box asking for confirmation
        */
        
        if(!categorysel) {
            var alert = UIAlertController(title: "Oops", message: "Please Select a category", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)

        }
        
        if(!datesel) {
            var alert = UIAlertController(title: "Oops", message: "Please choose a time", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        let newEvent = Event(owner: user, title: TitleField.text!, description: DescriptionView.text, category: CategorySelected, date:Date)
        
        // Upload to database

        BackendServices.SingleInstance.post_event(newEvent)
        
        // Storing with core data
        
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        var coreDataService = EventCoreDataService()
        coreDataService.saveEvent(context, newEvent: newEvent)
    
        clear()
    }
    
    @IBAction func SelectCategorySelected(sender: UIButton) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToDatePicker" {
          let vc = segue.destinationViewController as! DatePickerViewer
          let controller = vc.popoverPresentationController
            controller?.delegate = self
            vc.delegate = self
        } else {
          let vc = segue.destinationViewController as! CategoryPickerView
            let controller = vc.popoverPresentationController
            controller?.delegate = self
            vc.delegate = self
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
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
