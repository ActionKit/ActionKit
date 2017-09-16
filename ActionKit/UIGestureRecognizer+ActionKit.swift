//
//  UIGestureRecognizer+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit

// MARK:- UIGestureRecognizer actions
extension ActionKitSingleton {
    
    func addGestureClosure(_ gesture: UIGestureRecognizer, name: String, closure: ActionKitClosure) {
        let set: Set<String>? = gestureRecognizerToName[gesture]
        var newSet: Set<String>
        if let nonOptSet = set {
            newSet = nonOptSet
        } else {
            newSet = Set<String>()
        }
        newSet.insert(name)
        gestureRecognizerToName[gesture] = newSet
        controlToClosureDictionary[.gestureRecognizer(gesture, name)] = closure
    }
    
    func canRemoveGesture(_ gesture: UIGestureRecognizer, _ name: String) -> Bool {
        if let _ = controlToClosureDictionary[.gestureRecognizer(gesture, name)] {
            return true
        } else {
            return false
        }
    }
    
    func removeGesture(_ gesture: UIGestureRecognizer, name: String) {
        if canRemoveGesture(gesture, name) {
            controlToClosureDictionary[.gestureRecognizer(gesture, name)] = nil
        }
    }
    
    @objc(runGesture:)
    func runGesture(_ gesture: UIGestureRecognizer) {
        for gestureName in gestureRecognizerToName[gesture] ?? Set<String>() {
            if let closure = controlToClosureDictionary[.gestureRecognizer(gesture, gestureName)] {
                switch closure {
                case .noParameters(let voidClosure):
                    voidClosure()
                case .withGestureParameter(let gestureClosure):
                    gestureClosure(gesture)
                default:
                    assertionFailure("Gesture closure not found, nor void closure")
                    break
                }
            }
        }
    }
}

public extension UIGestureRecognizer {
    var actionKitNames: Set<String>? {
        get { return ActionKitSingleton.shared.gestureRecognizerToName[self] } set { }
    }
}

extension UIGestureRecognizer {
    public func clearActionKit() {
        let gestureRecognizerNames = ActionKitSingleton.shared.gestureRecognizerToName[self]
        ActionKitSingleton.shared.gestureRecognizerToName[self] = nil
        for gestureRecognizerName in gestureRecognizerNames ?? Set<String>() {
            ActionKitSingleton.shared.removeGesture(self, name: gestureRecognizerName)
        }
    }
    
    @objc public convenience init(_ name: String = "", _ gestureClosure: @escaping ActionKitGestureClosure) {
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
