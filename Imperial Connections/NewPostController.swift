//
//  NewPostController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 25/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit
import CoreData

class NewPostController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var DescriptionField: UITextField!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    var newEvent : Event = Event(eventID: 3, owner: User(login: "hannah"), title: "HI", description: "I like Webapp", category: Category.Recommended)
    var setting: Settings = Settings()
    var user:User!
    
    var data = Category.allCategories
    var CategorySelected = Category.Recommended
    override func viewDidLoad() {
        super.viewDidLoad()
        println(user.login)
        // Do any additional setup after loading the view.
        picker.delegate = self
        picker.dataSource = self
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
        DescriptionField.text = ""
    }
    
    
    @IBAction func SubmitButtonPress() {
        /*  TODO:
          pop up a box asking for confirmation
        */
        var eventID:Int!
        let newEvent = Event(eventID: eventID, owner: user, title: TitleField.text, description: DescriptionField.text, category:CategorySelected)
        /*  TODO:
        
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDel.managedObjectContext
        
        var ent = NSEntityDescription.entityForName("EventModel", inManagedObjectContext: context!)
        
        // Create entity for the core data model.
        var event = EventModel(entity: ent!, insertIntoManagedObjectContext: context)
        
        event.title = newEvent.title
        event.eventID = "\(newEvent.eventID)"
        event.descriptions = newEvent.description
        event.date = newEvent.date
        event.owner = newEvent.owner.login
        event.category = newEvent.category.rawValue
        
        context!.save(nil)
        
        println(event)
        println("Object saved!")
        
        clear()
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
      return 1
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int{
            return data.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int,
        forComponent component: Int) -> String!{
            return data[row].rawValue
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int,
        inComponent component: Int){
            println("selected row is " + data[row].rawValue)
            CategorySelected = data[row]
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
