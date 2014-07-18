//
//  UIGestureRecognizer+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi on 7/17/14.
//  Copyright (c) 2014 ActionKit. All rights reserved.
//

import Foundation
import UIKit

extension UIGestureRecognizer {
    
    convenience init(closure: () -> ()) {
        self.init(target: ActionKitSingleton.sharedInstance, action: Selector("runGesture:"))
        ActionKitSingleton.sharedInstance.addGestureClosure(self, closure: closure)
    }
    
    func addGestureRecognizer(closure: () -> ()) {
        self.addTarget(ActionKitSingleton.sharedInstance, action: Selector("runGesture:"))
        ActionKitSingleton.sharedInstance.addGestureClosure(self, closure: closure)
    }
}