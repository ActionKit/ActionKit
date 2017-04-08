//
//  ActionKitv2.swift
//  ActionKit
//
//  Created by Benjamin Hendricks on 4/8/17.
//  Copyright © 2017 ActionKit. All rights reserved.
//

import Foundation
import UIKit

public typealias ActionKitVoidClosure = () -> Void
public typealias ActionKitControlClosure = (UIControl) -> Void
public typealias ActionKitGestureClosure = (UIGestureRecognizer) -> Void
public typealias ActionKitBarButtonItemClosure = (UIBarButtonItem) -> Void

public enum ActionKitClosure {
    case noParameters(ActionKitVoidClosure)
    case withControlParameter(ActionKitControlClosure)
    case withGestureParameter(ActionKitGestureClosure)
    case withBarButtonItemParameter(ActionKitBarButtonItemClosure)
}

public enum ActionKitControlType: Hashable {
    case control(UIControl)
    case gestureRecognizer(UIGestureRecognizer)
    case barButtonItem(UIBarButtonItem)
    
    public var hashValue: Int {
        get {
            switch self {
            case .control(let control):
                return control.hashValue &* control.actionKitEvent.hashValue
            case .gestureRecognizer(let recognizer):
                return recognizer.hashValue &* recognizer.actionKitName.hashValue
            case .barButtonItem(let barButtonItem):
                return barButtonItem.hashValue
            }
        }
    }
}

public extension UIControl {
    var actionKitEvent: UIControlEvents {
        get {
            return self.actionKitEvent
        }
        set {
            self.actionKitEvent = newValue
        }
    }
}

public extension UIGestureRecognizer {
    var actionKitName: String {
        get {
            return self.actionKitName
            
        }
        set {
            self.actionKitName = newValue
        }
    }
}

public func ==(lhs: ActionKitControlType, rhs: ActionKitControlType) -> Bool {
    switch (lhs, rhs) {
    case (.control(let lhsControl), .control(let rhsControl)):
        return lhsControl.hashValue == rhsControl.hashValue && lhsControl.actionKitEvent == rhsControl.actionKitEvent
    case (.gestureRecognizer(let lhsRecognizer), .gestureRecognizer(let rhsRecognizer)):
        return lhsRecognizer.hashValue == rhsRecognizer.hashValue && lhsRecognizer.actionKitName == rhsRecognizer.actionKitName
    case (.barButtonItem(let lhsBarButtonItem), .barButtonItem(let rhsBarButtonItem)):
        return lhsBarButtonItem.hashValue == rhsBarButtonItem.hashValue
    default:
        return false
    }
}


public class ActionKitSingleton {
    public static let shared: ActionKitSingleton = ActionKitSingleton()
    private init() {}
    
    var controlToClosureDictionary = Dictionary<ActionKitControlType, ActionKitClosure>()
}

// MARK:- UIGestureRecognizer actions
extension ActionKitSingleton {
    
    func addGestureClosure(_ gesture: UIGestureRecognizer, name: String, closure: ActionKitClosure) {
        gesture.actionKitName = name
        let controlType: ActionKitControlType = .gestureRecognizer(gesture)
        controlToClosureDictionary[controlType] = closure
    }
    
    func canRemoveGesture(_ gesture: UIGestureRecognizer) -> Bool {
        if let _ = controlToClosureDictionary[.gestureRecognizer(gesture)] {
            return true
        } else {
            return false
        }
    }
    
    func removeGesture(_ gesture: UIGestureRecognizer, name: String) {
        gesture.actionKitName = name
        
        if canRemoveGesture(gesture) {
            controlToClosureDictionary[.gestureRecognizer(gesture)] = nil
        }
    }
    
    @objc(runGesture:)
    func runGesture(_ gesture: UIGestureRecognizer) {
        if let closure = controlToClosureDictionary[.gestureRecognizer(gesture)] {
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

// MARK:- UIControl actions
extension ActionKitSingleton {
    func removeAction(_ control: UIControl, controlEvent: UIControlEvents) {
        control.actionKitEvent = controlEvent
        controlToClosureDictionary[.control(control)] = nil
    }
    
    func addAction(_ control: UIControl, controlEvent: UIControlEvents, closure: ActionKitClosure)
    {
        control.actionKitEvent = controlEvent
        controlToClosureDictionary[.control(control)] = closure
    }
    
    @objc(runControlEventAction:)
    func runControlEventAction(_ control: UIControl) {
        if let closure = controlToClosureDictionary[.control(control)] {
            switch closure {
            case .noParameters(let voidClosure):
                voidClosure()
            case .withControlParameter(let controlClosure):
                controlClosure(control)
            default:
                assertionFailure("Control event closure not found, nor void closure")
                break
            }
        }
    }
}

// MARK:- UIBarButtonItem actions
extension ActionKitSingleton {
    func addBarButtonItemClosure(_ barButtonItem: UIBarButtonItem, closure: ActionKitClosure) {
        controlToClosureDictionary[.barButtonItem(barButtonItem)] = closure
    }
    
    func removeBarButtonItemClosure(_ barButtonItem: UIBarButtonItem) {
        controlToClosureDictionary[.barButtonItem(barButtonItem)] = nil
    }
    
    @objc(runBarButtonItem:)
    func runBarButtonItem(_ item: UIBarButtonItem) {
        if let closure = controlToClosureDictionary[.barButtonItem(item)] {
            switch closure {
            case .noParameters(let voidClosure):
                voidClosure()
            case .withBarButtonItemParameter(let barButtonItemClosure):
                barButtonItemClosure(item)
            default:
                assertionFailure("Bar button item closure not found, nor void closure")
                break
            }
        }
    }
}
