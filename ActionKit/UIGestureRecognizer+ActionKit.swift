//
//  UIGestureRecognizer+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Copyright (c) 2014 ActionKit. All rights reserved.
//

import Foundation
import UIKit

public extension UIGestureRecognizer {
    
    convenience init(name: String = "", closure: () -> ()) {
        self.init(target: ActionKitSingleton.sharedInstance, action: Selector("runGesture:"))
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: closure)
    }
    
    func addClosure(name: String, closure: () -> ()) {
//        self.addTarget(ActionKitSingleton.sharedInstance, action: Selector("runGesture:"))
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: closure)
    }
    
    func removeClosure(name: String) {
        if !ActionKitSingleton.sharedInstance.canRemoveGesture(self) {
            println("can remove a gesture closure")
            ActionKitSingleton.sharedInstance.removeGesture(self, name: name)
        } else {
            ActionKitSingleton.sharedInstance.removeGesture(self, name: name)
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector("runGesture:"))
        }
    }
}