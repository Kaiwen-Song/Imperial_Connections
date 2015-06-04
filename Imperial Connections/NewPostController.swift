//
//  NewPostController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 25/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class NewPostController: UIViewController {

    
    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var DescriptionField: UITextField!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var CategoryLabel: UILabel!
    var newEvent : Event = Event(eventID: 3, owner: User(login: "hannah"), title: "HI", description: "I like Webapp", category: Category.Recommended)
    var setting: Settings = Settings()
    var eventService: EventService = EventService ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        SearchBar.text = ""
    }
    
    @IBAction func SubmitButtonPress(sender: UIButton) {
        /*  TODO:
          pop up a box asking for confirmation
        */
        var user:User = User(login: "Hannah")
        var eventID:Int = 3
        let newEvent = Event(eventID: eventID, owner: user, title: TitleField.text, description: DescriptionField.text, category:Category.Recommended)
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        eventService.upload(newEvent, appDel: appDel)
        clear()
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
