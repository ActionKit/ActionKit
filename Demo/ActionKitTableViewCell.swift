//
//  ActionKitTableViewCell.swift
//  ActionKitDemo
//
//  Created by Benjamin Hendricks on 4/8/17.
//  Copyright © 2017 ActionKit. All rights reserved.
//

import UIKit
import ActionKit

public class ActionKitTableViewCell: UITableViewCell {
    static let kReuseID: String = "actionKitCell"

    var gestureRecognizer: UITapGestureRecognizer?
    
    public override func prepareForReuse() {
        gestureRecognizer?.clearActionKit()
        gestureRecognizer = nil
        contentView.backgroundColor = UIColor.clear
    }
    
    public func cellForRowAtIndexPathCalledDemo() {
        gestureRecognizer = UITapGestureRecognizer("setRed") {
            self.contentView.backgroundColor = UIColor.red
        }
        self.addGestureRecognizer(gestureRecognizer!)
    }
}
