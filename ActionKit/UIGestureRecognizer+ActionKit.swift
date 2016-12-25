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
    
    internal func castedActionKitGestureClosure(_ gesture: Self, closure: @escaping SpecificGestureClosure) -> ActionKitClosure {
        return ActionKitClosure.withGestureParameter( { (gestr: UIGestureRecognizer) in
            closure(gesture)
        })
    }
    
    init(name: String = "", closureWithGesture: @escaping SpecificGestureClosure) {
        self.init(target: ActionKitSingleton.sharedInstance, action: .runGesture)
        let akClosure = castedActionKitGestureClosure(self, closure: closureWithGesture)
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: akClosure)
    }

    func addClosure(_ name: String, closureWithGesture: @escaping SpecificGestureClosure) {
        let akClosure = castedActionKitGestureClosure(self, closure: closureWithGesture)
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: akClosure)
    }
}

extension UIGestureRecognizer: ActionKitGestureRecognizer {}

public extension UIGestureRecognizer {
    
    convenience init(name: String = "", closure: @escaping () -> ()) {
        self.init(target: ActionKitSingleton.sharedInstance, action: .runGesture)
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: .noParameters(closure))
    }

    func addClosure(_ name: String, closure: @escaping () -> ()) {
        ActionKitSingleton.sharedInstance.addGestureClosure(self, name: name, closure: .noParameters(closure))
    }

    func removeClosure(_ name: String) {
        if !ActionKitSingleton.sharedInstance.canRemoveGesture(self) {
            print("can remove a gesture closure")
            ActionKitSingleton.sharedInstance.removeGesture(self, name: name)
        } else {
            ActionKitSingleton.sharedInstance.removeGesture(self, name: name)
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runGesture)
        }
    }
}
