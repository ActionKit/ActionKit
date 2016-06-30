//
//  ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit


class ActionKitSingleton {
    var controlAndEventsDict: Dictionary<UIControl, Dictionary<UIControlEvents, () -> Void>> = Dictionary()
    var gestureDict: Dictionary<UIGestureRecognizer, [(String,()->Void)]> = Dictionary()
	var barButtonItemDict: Dictionary<UIBarButtonItem, () -> Void> = Dictionary()

    class var sharedInstance : ActionKitSingleton {
    struct ActionKit {
        static let instance : ActionKitSingleton = ActionKitSingleton()
        }
        return ActionKit.instance
    }
}
//
//  GESTURE ACTIONS
//
    
extension ActionKitSingleton {
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
    
}

//
// CLOSURE ACTIONS
//
extension ActionKitSingleton {
    func removeAction(control: UIControl, controlEvent: UIControlEvents) {
        if var innerDict = controlAndEventsDict[control] {
            innerDict.removeValueForKey(controlEvent);
        }
    }
    
    func addAction(control: UIControl, controlEvent: UIControlEvents, closure: () -> ())
    {
        if var innerDict = controlAndEventsDict[control] {
            innerDict[controlEvent] = closure
            controlAndEventsDict[control] = innerDict
        }
        else {
            var newDict = Dictionary<UIControlEvents, () -> Void>()
            newDict[controlEvent] = closure
            controlAndEventsDict[control] = newDict
        }
    }
    
    // Start the 19 different runClosure methods, each responding to a different UIControlEvents
    @objc(runClosureTouchDown:)
    func runClosureTouchDown(control: UIControl)
    {
        runAllClosures(control, event: .TouchDown)
    }
    
    @objc(runClosureTouchDownRepeat:)
    func runClosureTouchDownRepeat(control: UIControl)
    {
        runAllClosures(control, event: .TouchDownRepeat)
    }
    
    @objc(runClosureTouchDragInside:)
    func runClosureTouchDragInside(control: UIControl)
    {
        runAllClosures(control, event: .TouchDragInside)
    }
    
    @objc(runClosureTouchDragOutside:)
    func runClosureTouchDragOutside(control: UIControl)
    {
        runAllClosures(control, event: .TouchDragOutside)
    }
    
    @objc(runClosureTouchDragEnter:)
    func runClosureTouchDragEnter(control: UIControl)
    {
        runAllClosures(control, event: .TouchDragEnter)
    }
    
    @objc(runClosureTouchDragExit:)
    func runClosureTouchDragExit(control: UIControl)
    {
        runAllClosures(control, event: .TouchDragExit)
    }
    
    @objc(runClosureTouchUpInside:)
    func runClosureTouchUpInside(control: UIControl)
    {
        runAllClosures(control, event: .TouchUpInside)
    }
    
    @objc(runClosureTouchUpOutside:)
    func runClosureTouchUpOutside(control: UIControl)
    {
        runAllClosures(control, event: .TouchUpOutside)
    }
    
    @objc(runClosureTouchCancel:)
    func runClosureTouchCancel(control: UIControl)
    {
        runAllClosures(control, event: .TouchCancel)
    }
    
    @objc(runClosureValueChanged:)
    func runClosureValueChanged(control: UIControl)
    {
        runAllClosures(control, event: .ValueChanged)
    }
    
    @objc(runClosureEditingDidBegin:)
    func runClosureEditingDidBegin(control: UIControl)
    {
        runAllClosures(control, event: .EditingDidBegin)
    }
    
    @objc(runClosureEditingChanged:)
    func runClosureEditingChanged(control: UIControl)
    {
        runAllClosures(control, event: .EditingChanged)
    }
    
    @objc(runClosureEditingDidEnd:)
    func runClosureEditingDidEnd(control: UIControl)
    {
        runAllClosures(control, event: .EditingDidEnd)
    }
    
    @objc(runClosureEditingDidEndOnExit:)
    func runClosureEditingDidEndOnExit(control: UIControl)
    {
        runAllClosures(control, event: .EditingDidEndOnExit)
    }
    
    @objc(runClosureAllTouchEvents:)
    func runClosureAllTouchEvents(control: UIControl)
    {
        runAllClosures(control, event: .AllTouchEvents)
    }
    
    @objc(runClosureAllEditingEvents:)
    func runClosureAllEditingEvents(control: UIControl)
    {
        runAllClosures(control, event: .AllEditingEvents)
    }
    
    @objc(runClosureApplicationReserved:)
    func runClosureApplicationReserved(control: UIControl)
    {
        runAllClosures(control, event: .ApplicationReserved)
    }
    
    @objc(runClosureSystemReserved:)
    func runClosureSystemReserved(control: UIControl)
    {
        runAllClosures(control, event: .SystemReserved)
    }
    
    @objc(runClosureAllEvents:)
    func runClosureAllEvents(control: UIControl)
    {
        runAllClosures(control, event: .AllEvents)
    }
    
    
    private func runAllClosures(control: UIControl, event: UIControlEvents) {
        if let possibleClosures = controlAndEventsDict[control]?.filter({ $0.0.contains(event) }).map({ $0.1 }) {
            for closure in possibleClosures {
                closure()
            }
        }
    }
}

//
// UIBARBUTTONITEM ACTIONS
//
extension ActionKitSingleton {
	func addBarButtonItemClosure(barButtonItem: UIBarButtonItem, closure: () -> Void) {
		barButtonItemDict[barButtonItem] = closure
	}
	
	func removeBarButtonItemClosure(barButtonItem: UIBarButtonItem) {
		barButtonItemDict[barButtonItem] = nil
	}
	
	func barButtonItemClosure(barButtonItem: UIBarButtonItem) -> (() -> Void)? {
		return barButtonItemDict[barButtonItem]
	}
	
	@objc(runBarButtonItem:)
	func runBarButtonItem(item: UIBarButtonItem)
	{
		if let closure = barButtonItemDict[item] {
			closure()
		}
	}
}
