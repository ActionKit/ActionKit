//
//  UIGestureRecognizer+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit

extension UIGestureRecognizer {
    public convenience init(_ name: String = "", _ gestureClosure: @escaping ActionKitGestureClosure) {
        self.init(target: ActionKitSingleton.shared, action: #selector(ActionKitSingleton.runGesture(_:)))
        self.addClosure(name, gestureClosure: gestureClosure)
    }
 
    @nonobjc
    public convenience init(_ name: String = "", _ closure: @escaping ActionKitVoidClosure) {
        self.init(target: ActionKitSingleton.shared, action: #selector(ActionKitSingleton.runGesture(_:)))
        self.addClosure(name, closure: closure)
    }
    
    public func addClosure(_ name: String, gestureClosure: @escaping ActionKitGestureClosure) {
        ActionKitSingleton.shared.addGestureClosure(self, name: name, closure: .withGestureParameter(gestureClosure))
    }
    
    public func addClosure(_ name: String, closure: @escaping ActionKitVoidClosure) {
        ActionKitSingleton.shared.addGestureClosure(self, name: name, closure: .noParameters(closure))
    }
    
    public func removeClosure(_ name: String) {
        ActionKitSingleton.shared.removeGesture(self, name: name)
    }
}
