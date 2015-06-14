//
//  EventCell.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 27/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {


    //@IBOutlet weak var Icon: UIImageView!


    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet var background: UIImageView!
    var event:Event!
    required init(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
     
        
    }
    
    func update(){
        TitleLabel.text = event.title
        CategoryLabel.text = event.category.rawValue
        DateLabel.text = event.date
        var imageName = event.category.rawValue + ".png"
        Icon.image = UIImage(named:imageName)
        background.backgroundColor = UIColor.clearColor()
        background.layer.cornerRadius = 5
        background.layer.borderWidth = 1
        background.layer.borderColor = UIColor.grayColor().CGColor
       
        
    }
    
    
}
