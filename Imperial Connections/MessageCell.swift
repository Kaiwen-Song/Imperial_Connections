
//
//  MessageCell.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 02/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var SenderLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var MessageLabel: UILabel!
    
    var message:Message!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  self.textLabel.
    }

}
