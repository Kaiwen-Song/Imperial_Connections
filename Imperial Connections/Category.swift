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
    
    static let allCategories = [Recommended:0, Football:1, Music:2, Dancing:3, Photography:4, Basketball:5, Robotics:6, Tech:7]
    
    static var CategoryCount = allCategories.keys.array.count
}
