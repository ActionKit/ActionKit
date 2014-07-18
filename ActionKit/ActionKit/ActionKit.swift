//
//  ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi on 7/17/14.
//  Copyright (c) 2014 ActionKit. All rights reserved.
//

import Foundation
import UIKit

let runClosure = "runClosure:"
let runClosureTouchUpInside = "runClosureTouchUpInside:"



class ActionKitSingleton {
    var controlDict: Dictionary<UIControl, ()->Void> = Dictionary()
    var controlAndEventsDict: Dictionary<UIControl, Dictionary<ActionKitUIControlEventsStruct, () -> Void>> = Dictionary()
    var gestureDict: Dictionary<UIGestureRecognizer, ()->Void> = Dictionary()

    class var sharedInstance : ActionKitSingleton {
    struct ActionKit {
        static let instance : ActionKitSingleton = ActionKitSingleton()
        }
        return ActionKit.instance
    }
    
//
//  GESTURE ACTIONS
//
    
    func addGestureClosure(gesture: UIGestureRecognizer, closure: () -> ()) {
        gestureDict[gesture] = closure
    }
    @objc(runGesture:)
    func runGesture(gesture: UIGestureRecognizer) {
        if let possibleClosure = gestureDict[gesture] {
            possibleClosure()
        }
    }
    
//
// CLOSURE ACTIONS
//
    
    func addClosure(control: UIControl, closure: () -> ())
    {
        controlDict[control] = closure
    }
    
    func addAction(control: UIControl, controlEvent: UIControlEvents, closure: () -> ())
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: controlEvent)
        if var innerDict = controlAndEventsDict[control] {
            innerDict[controlStruct] = closure
        }
        else {
            var newDict = Dictionary<ActionKitUIControlEventsStruct, () -> Void>()
            newDict[controlStruct] = closure
            controlAndEventsDict[control] = newDict
        }
    }
    
    
    @objc(runClosureTouchUpInside:)
    func runClosureTouchUpInside(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.TouchUpInside)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    
    @objc(runClosure:)
    func runClosure(control: UIControl)
    {
        if let possibleClosure = controlDict[control] {
            possibleClosure()
        }
    }
}

