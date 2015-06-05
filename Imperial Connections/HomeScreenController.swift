//
//  HomeScreenController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 04/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class HomeScreenController: UITabBarController {

    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let subcontrollers = self.viewControllers
        let firstchild = subcontrollers![0] as! TestHomeScreenController
        let secondnav = subcontrollers![1] as! UINavigationController
        let secondchild = secondnav.topViewController as! MyEventsController
        let thirdchild = subcontrollers![2] as! NewPostController
        let fourthchild = subcontrollers![3] as! SettingsController
        firstchild.user = user
        secondchild.user = user
        thirdchild.user = user
        fourthchild.user = user
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
/*
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ToHomeScreen"){
            let dst = segue.destinationViewController as! TestHomeScreenController
            dst.user = self.user
        } else if (segue.identifier == "ToMyEvents"){
            let dst = segue.destinationViewController as! MyEventsController
            dst.user = self.user
        } else if (segue.identifier == "ToNewPost"){
            let dst = segue.destinationViewController as! NewPostController
            dst.user = self.user
        } else {
            let dst = segue.destinationViewController as! SettingsController
            dst.user = self.user
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
