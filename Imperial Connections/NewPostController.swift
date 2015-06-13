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

    
    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var DescriptionView: UITextView!
    @IBOutlet weak var CategoryLabel: UILabel!

    var user:User!
    var CategorySelected:Category!
    var Date:NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(user.login)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
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
    }
    
    
    @IBAction func SubmitButtonPress() {
        /*  TODO:
          pop up a box asking for confirmation
        */
        let newEvent = Event(owner: user, title: TitleField.text, description: DescriptionView.text, category: CategorySelected)
        
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
          var vc = segue.destinationViewController as! DatePickerViewer
          var controller = vc.popoverPresentationController
          if controller != nil {
            controller?.delegate = self
          }

        }else {
          var vc = segue.destinationViewController as! CategoryPickerView
            var controller = vc.popoverPresentationController
            controller?.delegate = self
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
