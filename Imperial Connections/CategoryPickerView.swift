//
//  CategoryPickerView.swift
//  Imperial Connections
//
//  Created by HyunAh Lee on 2015. 6. 13..
//  Copyright (c) 2015년 HJK Webapps. All rights reserved.
//

import UIKit

class CategoryPickerView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var picker: UIPickerView!
    var data = Category.allCategories.sorted{$0.rawValue < $1.rawValue}
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        //CategorySelected = data[row]
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
