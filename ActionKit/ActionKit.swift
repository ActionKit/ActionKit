//
//  ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit

//: ## Having an UIControl as optional input parameter for the closure
//:
//: We like to have the UIControl as input parameter in the closure, like this:
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) { (control: UIControl) in
//:         print("the control: \(control) was tapped")
//:     }
//: ```
//:
//: But unfortunately, there is a bug in the swift compiler, that prevents implicit
//: arguments in the closure. This bug will cause an error when the argument is ignored
//: implicitly. That means that if you would try to use a closure which has a argument
//: `(control: UIContol)`, without that argument like this:
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) {
//:         print("this control was tapped")
//:     }
//: ```
//:
//: Then the compiler will give an error:
//:
//: ```Contextual type for closure argument list expects 1 argument, which cannot be implicitlty ignored```
//:
//: See Chris Lattner's option on the matter (that this is a compiler bug):
//: [http://article.gmane.org/gmane.comp.lang.swift.evolution/17196/](http://article.gmane.org/gmane.comp.lang.swift.evolution/17196/)
//:
//: ### Workaround by having multiple functions
//:
//: We can workaround this bug by having multiple functions, one without the `UIControl` parameter
//: (the original) and one with the `(control: UIControl) in` parameter. The only downside is that
//: you will have to call the closure with a specific signature, so either with:
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) {
//:         ...
//:     }
//: ```
//:
//: or with:
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) { (control: UIControl) in
//:         ...
//:     }
//: ```
//:
//: but not with:
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) { aButton in
//:         ...
//:     }
//: ```
//:
//: or with
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) { _ in
//:         ...
//:     }
//: ```
//:
//: Because `aButton` or `_` is not specific enough and the compiler will complain with:
//:
//: ```Ambiguous use of 'addControlEvent'```
//:
//: So, until this bug is solved in the Swift compiler, we will have to use **two** functions
//: for each control event, and be specific with the arguments in the closure call.
//:


typealias ActionKitVoidClosure = () -> Void
public typealias ActionKitControlClosure = (UIControl) -> Void
public typealias ActionKitGestureClosure = (UIGestureRecognizer) -> Void

enum ActionKitClosure {
    case NoParameters(ActionKitVoidClosure)
    case WithControlParameter(ActionKitControlClosure)
    case WithGestureParameter(ActionKitGestureClosure)
}

class ActionKitSingleton {
    var controlAndEventsDict: Dictionary<UIControl, Dictionary<UIControlEvents, ActionKitClosure>> = Dictionary()
    var gestureDict: Dictionary<UIGestureRecognizer, [(String, ActionKitClosure)]> = Dictionary()

    class var sharedInstance : ActionKitSingleton {
    struct ActionKit {
        static let instance : ActionKitSingleton = ActionKitSingleton()
        }
        return ActionKit.instance
    }
}

//:
//: # GESTURE ACTIONS
//:
    
extension ActionKitSingleton {
    
    func addGestureClosure(gesture: UIGestureRecognizer, name: String, closure: ActionKitClosure) {
        if var gestureArr = gestureDict[gesture] {
            gestureArr.append(name, closure)
            gestureDict[gesture] = gestureArr
        } else {
            var newGestureArr = Array<(String, ActionKitClosure)>()
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
                switch possibleClosureTuple.1 {
                case .NoParameters(let closure):
                    closure()
                    break
                case .WithGestureParameter(let closure):
                    closure(gesture)
                    break
                default:
                    // It shouldn't be a ControlClosure
                    break
                }
            }
        }
    }
    
}

//:
//: # CLOSURE ACTIONS
//:

extension ActionKitSingleton {
    func removeAction(control: UIControl, controlEvent: UIControlEvents) {
        if var innerDict = controlAndEventsDict[control] {
            innerDict.removeValueForKey(controlEvent);
        }
    }
    
    func addAction(control: UIControl, controlEvent: UIControlEvents, closure: ActionKitClosure)
    {
        if var innerDict = controlAndEventsDict[control] {
            innerDict[controlEvent] = closure
            controlAndEventsDict[control] = innerDict
        }
        else {
            var newDict = Dictionary<UIControlEvents, ActionKitClosure>()
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
            for actionKitClosure in possibleClosures {
                switch actionKitClosure {
                case .NoParameters(let closure):
                    closure()
                    break
                case .WithControlParameter(let closure):
                    closure(control)
                    break
                default:
                    // It shouldn't be a ControlClosure
                    break
                }
            }
        }
    }
}

