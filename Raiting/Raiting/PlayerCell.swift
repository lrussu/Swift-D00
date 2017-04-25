//
//  PlayerCellTableViewCell.swift
//  Raiting
//
//  Created by Liudmila Russu on 4/20/17.
//  Copyright © 2017 Liudmila Russu. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    weak var dateLabel: UILabel!
    
    var person: Person! {
        didSet {
            gameLabel.text = person.reason
            nameLabel.text = person.name
            dateLabel.text = person.date
            
        }
    }


}


