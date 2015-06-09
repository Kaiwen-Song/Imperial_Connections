//
//  UserModel.swift
//  Imperial Connections
//
//  Created by HyunAh Lee on 2015. 6. 8..
//  Copyright (c) 2015년 HJK Webapps. All rights reserved.
//

import UIKit
import CoreData

@objc(UserModel)
class UserModel : NSManagedObject {
    @NSManaged var username:String
    @NSManaged var password:String
}
