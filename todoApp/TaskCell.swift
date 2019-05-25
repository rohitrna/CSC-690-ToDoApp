//
//  TaskCell.swift
//  todoApp
//
//  Created by Rohit Nair on 3/29/19.
//  Copyright © 2019 Rohit Nair. All rights reserved.
//

import UIKit
protocol ChangeButton{
    func changeButton(checked: Bool, index: Int)
}

class TaskCell: UITableViewCell {
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if tasks![indexP!].checked {
            delegate?.changeButton(checked: false,  index: indexP!)
        } else{
            delegate?.changeButton(checked: true,  index: indexP!)
        }
    }
    
    @IBOutlet weak var tasknameLabel: UILabel!
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    var delegate: ChangeButton?
    var indexP: Int?
    var tasks: [Task]?
    
}
