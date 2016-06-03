//
//  UIGestureRecognizer+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit

private extension Selector {
    
    static let runGesture = #selector(ActionKitSingleton.runGesture(_:))
    
}

public extension UIGestureRecognizer {
    
    convenience init(name: String = "", closure: () -> ()) {
        self.init(target: ActionKitSingleton.sharedInstance, action: .runGesture)
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: .NoParameters(closure))
    }

    convenience init(name: String = "", closureWithGesture: (UIGestureRecognizer) -> ()) {
        self.init(target: ActionKitSingleton.sharedInstance, action: .runGesture)
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: .WithGestureParameter(closureWithGesture))
    }

    func addClosure(name: String, closure: () -> ()) {
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: .NoParameters(closure))
    }

    func addClosure(name: String, closureWithGesture: (UIGestureRecognizer) -> ()) {
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: .WithGestureParameter(closureWithGesture))
    }

    func removeClosure(name: String) {
        if !ActionKitSingleton.sharedInstance.canRemoveGesture(self) {
            print("can remove a gesture closure")
            ActionKitSingleton.sharedInstance.removeGesture(self, name: name)
        } else {
            ActionKitSingleton.sharedInstance.removeGesture(self, name: name)
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runGesture)
        }
    }
}