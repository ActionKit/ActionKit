//
//  UIControl+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi on 7/17/14.
//  Copyright (c) 2014 ActionKit. All rights reserved.
//

import Foundation
import UIKit

extension UIControl {
    func addControlEvent(controlEvents: UIControlEvents, forAction closure: () -> ()) {
        self.addTarget(ActionKitSingleton.sharedInstance(), action: Selector("runClosure:"), forControlEvents: .TouchUpInside)
        ActionKitSingleton.sharedInstance().addAction(self, closure)
    }
}