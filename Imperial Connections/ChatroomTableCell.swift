//
//  MessageTableCell.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 01/06/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import UIKit

class ChatroomTableCell: UITableViewCell {

    @IBOutlet weak var MessageTitleLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    var chatroom:Chatroom!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(){
        MessageTitleLabel.text = chatroom.sender.login
    }
}
