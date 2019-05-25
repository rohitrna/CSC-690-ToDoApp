//
//  Task.swift
//  todoApp
//
//  Created by Rohit Nair on 4/28/19.
//  Copyright © 2019 Rohit Nair. All rights reserved.
//

import Foundation
class Task: Codable {
    var name = ""
    var checked = false
    convenience init(name:String){
        self.init()
        self.name = name
}
}
