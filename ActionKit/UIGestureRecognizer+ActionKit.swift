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
    public func addClosure(_ name: String, closure: @escaping () -> ()) {
        ActionKitSingleton.shared.addGestureClosure(self, name: name, closure: .noParameters(closure))
    }
    
    public func addClosure(_ name: String, gestureClosure: @escaping (UIGestureRecognizer) -> ()) {
        ActionKitSingleton.shared.addGestureClosure(self, name: name, closure: .withGestureParameter(gestureClosure))
    }
    
    public func removeClosure(_ name: String) {
        ActionKitSingleton.shared.removeGesture(self, name: name)
    }
}


