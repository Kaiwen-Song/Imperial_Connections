//
//  DatePickerView.swift
//  Imperial Connections
//
//  Created by HyunAh Lee on 2015. 6. 13..
//  Copyright (c) 2015년 HJK Webapps. All rights reserved.
//

import UIKit

class DatePickerViewer: UIViewController{
    var delegate:NewPostController!
    
    var formatter:NSDateFormatter!
    @IBOutlet weak var picker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ConfirmButtonPress(sender: UIButton) {
        delegate.Date = formatter.stringFromDate(picker.date)
        delegate.SelectDateButton.setTitle(delegate.Date, forState: UIControlState.Normal)
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
