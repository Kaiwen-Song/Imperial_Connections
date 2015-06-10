
//
//  LoginScreen.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 04/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit
import CoreData

class LoginScreen: UIViewController {

    @IBOutlet weak var LoginField: UITextField!
    @IBOutlet weak var Password: UITextField!

    var successLogIn : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromCoreData()
        // Do any additional setup after loading the view.
    }

    
    func saveToCoreData() {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let ent = NSEntityDescription.entityForName("UserModel", inManagedObjectContext: context)
        var newUser = UserModel(entity: ent!, insertIntoManagedObjectContext: context)
        newUser.username = LoginField.text
        newUser.password = Password.text
        
        context.save(nil)
        println("SAVED!!!")
        // to handle the NSErrorPointer, please modify
    }
    
    func fetchUserFromCoreData() -> User {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let request = NSFetchRequest(entityName: "UserModel")
        request.returnsObjectsAsFaults = false;
        
        var results:NSArray = context.executeFetchRequest(request, error: nil)!
        var user:UserModel = results[0] as! UserModel
        var newUser: User = User(login: user.username)
      
        return newUser
    }
    
    func loadFromCoreData() {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let request = NSFetchRequest(entityName: "UserModel")
        request.returnsObjectsAsFaults = false;
        //request.predicate = NSPredicate(format: "username = %@", LoginField.text)
        var results:NSArray = context.executeFetchRequest(request, error: nil)!
        var isLoggedOn = results.count
        if isLoggedOn > 0 { /* When the user is already logged on */
            /* load the data from database and compare it with the core data using get_user */
            for user in results {
                var thisUser = user as! UserModel
                var id = thisUser.username
                var password = thisUser.password
                if (BackendServices().get_user(id, password: password)) {
                    /* log in detail of core data matches the database */
                    /* skip the log in page */
                    self.performSegueWithIdentifier("ToTabScreen", sender: self)
                    break
                    
                }
                else {
                    var alert = UIAlertController(title: "Log On Error", message: "Please check your log in details or your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOnButton(sender: AnyObject) {
        // Check login details with database 
        // If successful then goto tab screen, if not pop up error message
        let backend = BackendServices()
        successLogIn = backend.get_user(LoginField.text!, password: Password.text)
       // successLogIn = backend.get_user("Jeffrey", password: "11111")
        if successLogIn {
            self.performSegueWithIdentifier("ToTabScreen", sender: self)
            saveToCoreData()
        } else {
            var alert = UIAlertController(title: "Log On Error", message: "Please check your log in details or your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let user = User(login:LoginField.text) HACKED
        let user = User(login:"Jeffrey")
        let dst = segue.destinationViewController as! HomeScreenController
        dst.user = user
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
