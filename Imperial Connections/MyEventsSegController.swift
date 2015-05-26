//
//  MyEventsSegController.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 26/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class MyEventsSegController: UIViewController {

    @IBOutlet weak var MyEvents: UIView!
    @IBOutlet weak var WatchedEvents: UIView!
    @IBOutlet weak var segmentation: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func IndexChanged(sender: UISegmentedControl) {
        switch segmentation.selectedSegmentIndex{
        case 0:
            MyEvents.hidden = false
            WatchedEvents.hidden = true
        case 1:
            MyEvents.hidden = true
            WatchedEvents.hidden = false
        default:
            break
        }
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
