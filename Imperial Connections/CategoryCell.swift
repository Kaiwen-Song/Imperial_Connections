//
//  CategoryCell.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit
import CoreData

class CategoryCell: UITableViewCell {

    @IBOutlet weak var CategoryLabel: UILabel!
    var category:Category!
    var events: [Event] = [Event]()

    @IBOutlet var Icon: UIImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func setCategory(category:Category){
        self.category = category
        CategoryLabel.text = category.rawValue
        let imageName = category.rawValue + ".png"
        Icon.image = UIImage(named: imageName)
        
        
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let coreDataService = EventCoreDataService()
        if (events.count == 0) {
            // Retrieve certain category events
            let backend = BackendServices.SingleInstance
            events = backend.get_category_event(category)
            
            //Storing core data
            
            for event in events {
                coreDataService.saveEvent(context, newEvent: event)
            }
        }
        
        //coreDataService.fetchEvent(context)
        
        
        
        // TODO: retrieve image data from database
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
