//
//  QnA.swift
//  Imperial Connections
//
//  Created by Kaiwen Song on 28/05/2015.
//  Copyright (c) 2015 HJK Webapps. All rights reserved.
//

import Foundation
public class QnA {
    let question:String
    var reply:String
    let questionID: Int
    
    init(questionID:Int, question:String){
        self.questionID = questionID
        self.question = question
        self.reply = ""
    }
    
    func postAnswer(answer:String)->QnA{
        self.reply = answer
        return self
    }
}