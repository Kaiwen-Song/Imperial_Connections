
//
//  LoginScreen.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 04/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class LoginScreen: UIViewController {

    @IBOutlet weak var LoginField: UITextField!
    @IBOutlet weak var Password: UITextField!
    var successLogIn : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOnButton(sender: AnyObject) {
        // Check login details with database 
        // If successful then goto tab screen, if not pop up error message
        let backend = BackendServices()
        successLogIn = backend.get_user("Jeffrey", password: "11111")
        if successLogIn {
            self.performSegueWithIdentifier("ToTabScreen", sender: self)
        } else {
            var alert = UIAlertController(title: "Log On Error", message: "Please check your log in details or your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let user = User(login:LoginField.text)
        let dst = segue.destinationViewController as! HomeScreenController
        dst.user = user
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
