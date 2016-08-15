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
    
    static let runGesture = #selector(ActionKitSingleton.runGesture(gesture:))
    
}

public protocol ActionKitGestureRecognizer {}

public extension ActionKitGestureRecognizer where Self: UIGestureRecognizer {

    typealias SpecificGestureClosure = (Self) -> ()
    
    internal func castedActionKitGestureClosure(gesture: Self, closure: SpecificGestureClosure) -> ActionKitClosure {
        return ActionKitClosure.WithGestureParameter( { (gestr: UIGestureRecognizer) in
            closure(gesture)
        })
    }
    
    init(name: String = "", closureWithGesture: SpecificGestureClosure) {
        self.init(target: ActionKitSingleton.sharedInstance, action: .runGesture)
        let akClosure = castedActionKitGestureClosure(gesture: self, closure: closureWithGesture)
        ActionKitSingleton.sharedInstance.addGestureClosure(gesture: self, name: name, closure: akClosure)
    }

    func addClosure(name: String, closureWithGesture: SpecificGestureClosure) {
        let akClosure = castedActionKitGestureClosure(gesture: self, closure: closureWithGesture)
        ActionKitSingleton.sharedInstance.addGestureClosure(gesture: self, name: name, closure: akClosure)
    }
}

extension UIGestureRecognizer: ActionKitGestureRecognizer {}

public extension UIGestureRecognizer {
    
    convenience init(name: String = "", closure: @escaping () -> ()) {
        self.init(target: ActionKitSingleton.sharedInstance, action: .runGesture)
        ActionKitSingleton.sharedInstance.addGestureClosure(gesture: self, name: name, closure: .NoParameters(closure))
    }

    func addClosure(name: String, closure: @escaping () -> ()) {
        ActionKitSingleton.sharedInstance.addGestureClosure(gesture: self, name: name, closure: .NoParameters(closure))
    }

    func removeClosure(name: String) {
        if !ActionKitSingleton.sharedInstance.canRemoveGesture(gesture: self) {
            print("can remove a gesture closure")
            ActionKitSingleton.sharedInstance.removeGesture(gesture: self, name: name)
        } else {
            ActionKitSingleton.sharedInstance.removeGesture(gesture: self, name: name)
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runGesture)
        }
    }
}
