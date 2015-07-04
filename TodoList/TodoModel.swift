//
//  ToDoModel.swift
//  TodoList
//
//  Created by wentilin on 15/7/4.
//  Copyright (c) 2015年 wentilin. All rights reserved.
//

import UIKit

class TodoModel: NSObject {
    var id: String
    var title: String
    var date: NSDate
    var image: String
    
    init(id: String, image: String, title: String, date: NSDate) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}
