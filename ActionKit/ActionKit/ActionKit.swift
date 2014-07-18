//
//  ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi on 7/17/14.
//  Copyright (c) 2014 ActionKit. All rights reserved.
//

import Foundation
import UIKit

// legacy
let runClosure = "runClosure:"

// All 19 UIControlEvents
let runClosureTouchDown = "runClosureTouchDown:"
let runClosureTouchDownRepeat = "runClosureTouchDownRepeat:"
let runClosureTouchDragInside = "runClosureTouchDragInside:"
let runClosureTouchDragOutside = "runClosureTouchDragOutside:"
let runClosureTouchDragEnter = "runClosureTouchDragEnter:"
let runClosureTouchDragExit = "runClosureTouchDragExit:"
let runClosureTouchUpInside = "runClosureTouchUpInside:"
let runClosureTouchUpOutside = "runClosureTouchUpOutside:"
let runClosureTouchCancel = "runClosureTouchCancel:"
let runClosureValueChanged = "runClosureValueChanged:"
let runClosureEditingDidBegin = "runClosureEditingDidBegin:"
let runClosureEditingChanged = "runClosureEditingChanged:"
let runClosureEditingDidEnd = "runClosureEditingDidEnd:"
let runClosureEditingDidEndOnExit = "runClosureEditingDidEndOnExit:"
let runClosureAllTouchEvents = "runClosureAllTouchEvents:"
let runClosureAllEditingEvents = "runClosureAllEditingEvents:"
let runClosureApplicationReserved = "runClosureApplicationReserved:"
let runClosureSystemReserved = "runClosureSystemReserved:"
let runClosureAllEvents = "runClosureAllEvents:"




class ActionKitSingleton {
    // legacy code (1 line)
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
    
    func removeGesture(gesture: UIGestureRecognizer) {
        gestureDict.removeValueForKey(gesture)
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
    
    // legacy code
    
    func addClosure(control: UIControl, closure: () -> ())
    {
        controlDict[control] = closure
    }
    
    @objc(runClosure:)
    func runClosure(control: UIControl)
    {
        if let possibleClosure = controlDict[control] {
            possibleClosure()
        }
    }
    // end legacy code
    
    func addAction(control: UIControl, controlEvent: UIControlEvents, closure: () -> ())
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: controlEvent)
        if var innerDict = controlAndEventsDict[control] {
            innerDict[controlStruct] = closure
            controlAndEventsDict[control] = innerDict
        }
        else {
            var newDict = Dictionary<ActionKitUIControlEventsStruct, () -> Void>()
            newDict[controlStruct] = closure
            controlAndEventsDict[control] = newDict
        }
    }
    
    // Start the 19 different runClosure methods, each responding to a different UIControlEvents
    @objc(runClosureTouchDown:)
    func runClosureTouchDown(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.TouchDown)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureTouchDownRepeat:)
    func runClosureTouchDownRepeat(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.TouchDownRepeat)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureTouchDragInside:)
    func runClosureTouchDragInside(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.TouchDragInside)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureTouchDragOutside:)
    func runClosureTouchDragOutside(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.TouchDragOutside)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureTouchDragEnter:)
    func runClosureTouchDragEnter(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.TouchDragEnter)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureTouchDragExit:)
    func runClosureTouchDragExit(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.TouchDragExit)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
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
    
    @objc(runClosureTouchUpOutside:)
    func runClosureTouchUpOutside(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.TouchUpOutside)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureTouchCancel:)
    func runClosureTouchCancel(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.TouchCancel)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureValueChanged:)
    func runClosureValueChanged(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.ValueChanged)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureEditingDidBegin:)
    func runClosureEditingDidBegin(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.EditingDidBegin)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureEditingChanged:)
    func runClosureEditingChanged(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.EditingChanged)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureEditingDidEnd:)
    func runClosureEditingDidEnd(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.EditingDidEnd)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureEditingDidEndOnExit:)
    func runClosureEditingDidEndOnExit(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.EditingDidEndOnExit)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureAllTouchEvents:)
    func runClosureAllTouchEvents(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.AllTouchEvents)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureAllEditingEvents:)
    func runClosureAllEditingEvents(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.AllEditingEvents)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureApplicationReserved:)
    func runClosureApplicationReserved(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.ApplicationReserved)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureSystemReserved:)
    func runClosureSystemReserved(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.SystemReserved)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosureAllEvents:)
    func runClosureAllEvents(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.AllEvents)
        if let innerDict = controlAndEventsDict[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
}

