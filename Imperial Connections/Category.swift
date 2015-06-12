//
//  Category.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 26/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation
public enum Category : String{
    case Recommended = "Recommended"
    case Football = "Football"
    case Music = "Music"
    case Dancing = "Dancing"
    case Photography = "Photography"
    case Basketball = "Basketball"
    case Robotics = "Robotics"
    case Tech = "Tech"
    
    static let allCategories = [Football, Music, Dancing, Photography, Basketball, Robotics, Tech]
    
    static let categoryindex = [Football:0, Music:1, Dancing:2, Photography:3, Basketball:4, Robotics:5, Tech:6]
    
    static var CategoryCount = allCategories.count
}
