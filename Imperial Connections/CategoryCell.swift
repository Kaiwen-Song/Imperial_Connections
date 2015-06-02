//
//  CategoryCell.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var CategoryLabel: UILabel!
    var category:Category!

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func setCategory(category:Category){
        self.category = category
        CategoryLabel.text = category.rawValue
        //retrieve image data from database
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
