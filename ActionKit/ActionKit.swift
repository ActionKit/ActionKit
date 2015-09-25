//
//  ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit

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
    var controlAndEventsDict: Dictionary<UIControl, Dictionary<ActionKitUIControlEventsStruct, () -> Void>> = Dictionary()
    var gestureDict: Dictionary<UIGestureRecognizer, [(String,()->Void)]> = Dictionary()

    class var sharedInstance : ActionKitSingleton {
    struct ActionKit {
        static let instance : ActionKitSingleton = ActionKitSingleton()
        }
        return ActionKit.instance
    }
    
//
//  GESTURE ACTIONS
//
    
    func addGestureClosure(gesture: UIGestureRecognizer, name: String, closure: () -> ()) {
//        gestureDict[gesture] = closure
        if var gestureArr = gestureDict[gesture] {
            gestureArr.append(name, closure)
            gestureDict[gesture] = gestureArr
        } else {
            var newGestureArr = Array<(String, ()->Void)>()
            newGestureArr.append(name, closure)
            gestureDict[gesture] = newGestureArr
        }
        
        
    }
    
    func canRemoveGesture(gesture: UIGestureRecognizer) -> Bool {
        if let gestureArray = gestureDict[gesture] {
            if gestureArray.count == 1 {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func removeGesture(gesture: UIGestureRecognizer, name: String) {
//        gestureDict.removeValueForKey(gesture)
        if var gestureArray = gestureDict[gesture] {
            var x: Int = 0
            for (index, gestureTuple) in gestureArray.enumerate() {
                if gestureTuple.0 == name {
                    x = index
                }
            }
            gestureArray.removeAtIndex(x)
            gestureDict[gesture] = gestureArray
        } else {
            gestureDict.removeValueForKey(gesture)
        }
    }
    
    @objc(runGesture:)
    func runGesture(gesture: UIGestureRecognizer) {
        if let gestureArray = gestureDict[gesture] {
            for possibleClosureTuple in gestureArray {
                // println("running closure named: \(possibleClosureTuple.0)")
                (possibleClosureTuple.1)()
            }
        }
    }
    
//
// CLOSURE ACTIONS
//
    
    func removeAction(control: UIControl, controlEvent: UIControlEvents) {
        let controlStruct = ActionKitUIControlEventsStruct(value: controlEvent)
        if var innerDict = controlAndEventsDict[control] {
            innerDict.removeValueForKey(controlStruct);
        }
    }
    
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

