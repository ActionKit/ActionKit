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

public protocol ActionKitGestureRecognizer {}

public extension ActionKitGestureRecognizer where Self: UIGestureRecognizer {

    typealias SpecificGestureClosure = (Self) -> ()
    
    init(name: String = "", closureWithGesture: SpecificGestureClosure) {
        self.init(target: ActionKitSingleton.sharedInstance, action: .runGesture)
        let akClosure = ActionKitClosure.WithGestureParameter(closureWithGesture as! ActionKitGestureClosure)
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: akClosure)
    }

    func addClosure(name: String, closureWithGesture: SpecificGestureClosure) {
        let akClosure = ActionKitClosure.WithGestureParameter(closureWithGesture as! ActionKitGestureClosure)
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: akClosure)
    }
}

extension UIGestureRecognizer: ActionKitGestureRecognizer {}

public extension UIGestureRecognizer {
    
    convenience init(name: String = "", closure: () -> ()) {
        self.init(target: ActionKitSingleton.sharedInstance, action: .runGesture)
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: .NoParameters(closure))
    }

    func addClosure(name: String, closure: () -> ()) {
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: .NoParameters(closure))
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