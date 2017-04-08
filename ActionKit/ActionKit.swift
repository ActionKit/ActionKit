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
    case control(UIControl, UIControlEvents)
    case gestureRecognizer(UIGestureRecognizer, String)
    case barButtonItem(UIBarButtonItem)
    
    public var hashValue: Int {
        get {
            switch self {
            case .control(let control, let controlEvent):
                return control.hashValue &* controlEvent.hashValue
            case .gestureRecognizer(let recognizer, let name):
                return recognizer.hashValue &* name.hashValue
            case .barButtonItem(let barButtonItem):
                return barButtonItem.hashValue
            }
        }
    }
}

public extension UIControl {
    var actionKitEvents: Set<UIControlEvents>? {
        get { return ActionKitSingleton.shared.controlToControlEvent[self] } set {}
    }
}

public extension UIGestureRecognizer {
    var actionKitNames: Set<String>? {
        get { return ActionKitSingleton.shared.gestureRecognizerToName[self] } set { }
    }
}

public func ==(lhs: ActionKitControlType, rhs: ActionKitControlType) -> Bool {
    switch (lhs, rhs) {
    case (.control(let lhsControl, let lhsControlEvent), .control(let rhsControl, let rhsControlEvent)):
        return lhsControl.hashValue == rhsControl.hashValue && lhsControlEvent.hashValue == rhsControlEvent.hashValue
    case (.gestureRecognizer(let lhsRecognizer, let lhsName), .gestureRecognizer(let rhsRecognizer, let rhsName)):
        return lhsRecognizer.hashValue == rhsRecognizer.hashValue && lhsName == rhsName
    case (.barButtonItem(let lhsBarButtonItem), .barButtonItem(let rhsBarButtonItem)):
        return lhsBarButtonItem.hashValue == rhsBarButtonItem.hashValue
    default:
        return false
    }
}


public class ActionKitSingleton {
    public static let shared: ActionKitSingleton = ActionKitSingleton()
    private init() {}
    
    var controlToControlEvent = Dictionary<UIControl, Set<UIControlEvents>>()
    var gestureRecognizerToName = Dictionary<UIGestureRecognizer, Set<String>>()
    var controlToClosureDictionary = Dictionary<ActionKitControlType, ActionKitClosure>()
    
}

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

// MARK:- UIControl actions
extension ActionKitSingleton {
    func removeAction(_ control: UIControl, controlEvent: UIControlEvents) {
        var eventSet = control.actionKitEvents
        if eventSet?.contains(controlEvent) ?? false {
            let _ = eventSet?.remove(controlEvent)
        }
        controlToClosureDictionary[.control(control, controlEvent)] = nil
    }
    
    func addAction(_ control: UIControl, controlEvent: UIControlEvents, closure: ActionKitClosure)
    {
        let set: Set<UIControlEvents>? = controlToControlEvent[control]
        var newSet: Set<UIControlEvents>
        if let nonOptSet = set {
            newSet = nonOptSet
        } else {
            newSet = Set<UIControlEvents>()
        }
        newSet.insert(controlEvent)
        controlToControlEvent[control] = newSet
        controlToClosureDictionary[.control(control, controlEvent)] = closure
    }
    
    @objc(runControlEventAction:)
    func runControlEventAction(_ control: UIControl) {
        for controlEvent in control.actionKitEvents ?? Set<UIControlEvents>() {
            if let closure = controlToClosureDictionary[.control(control, controlEvent)] {
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
