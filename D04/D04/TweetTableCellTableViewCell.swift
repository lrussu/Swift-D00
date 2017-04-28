//
//  TweetTableCellTableViewCell.swift
//  D04
//
//  Created by Liudmila Russu on 4/27/17.
//  Copyright © 2017 Liudmila Russu. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    let tweetDateFormat = "EEE MMM d HH:mm:ss Z yyyy"
    let newTweetDateFormat = "d MMM yyyy"
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.name
            tweetLabel.text = tweet.text
            dateLabel.text = tweet.date
            dateFormatter.dateFormat = tweetDateFormat
            if let d = dateFormatter.date(from: tweet.date)
            {
                dateFormatter.dateFormat = newTweetDateFormat
                dateLabel.text = dateFormatter.string(from: d)
            }
            
            
        }
    }
    
}

