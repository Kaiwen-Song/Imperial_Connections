//
//  CategoryCollectionCell.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
  
    //@IBOutlet weak var Icon: UIImageView!
    
    
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var Name: UILabel!
    
    var category:Category!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(){
        Name.text = category.rawValue
        var imageName = category.rawValue + ".png"
        Icon.image = UIImage(named:imageName)
    }
    
}
