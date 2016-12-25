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
public typealias ActionKitBarButtonItemClosure = (UIBarButtonItem) -> Void

enum ActionKitClosure {
	case noParameters(ActionKitVoidClosure)
	case withControlParameter(ActionKitControlClosure)
	case withGestureParameter(ActionKitGestureClosure)
	case withBarButtonItemParameter(ActionKitBarButtonItemClosure)
}

class ActionKitSingleton {
	var controlAndEventsDict: Dictionary<UIControl, Dictionary<UIControlEvents, ActionKitClosure>> = Dictionary()
	var gestureDict: Dictionary<UIGestureRecognizer, [(String, ActionKitClosure)]> = Dictionary()
	var barButtonItemDict: Dictionary<UIBarButtonItem, ActionKitClosure> = Dictionary()
	
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
	
	func addGestureClosure(_ gesture: UIGestureRecognizer, name: String, closure: ActionKitClosure) {
		if var gestureArr = gestureDict[gesture] {
			gestureArr.append(name, closure)
			gestureDict[gesture] = gestureArr
		} else {
			var newGestureArr = Array<(String, ActionKitClosure)>()
			newGestureArr.append(name, closure)
			gestureDict[gesture] = newGestureArr
		}
		
		
	}
	
	func canRemoveGesture(_ gesture: UIGestureRecognizer) -> Bool {
		if let gestureArray = gestureDict[gesture] {
			if gestureArray.count == 1 {
				return true
			} else {
				return false
			}
		}
		return false
	}
	
	func removeGesture(_ gesture: UIGestureRecognizer, name: String) {
		if var gestureArray = gestureDict[gesture] {
			var x: Int = 0
			for (index, gestureTuple) in gestureArray.enumerated() {
				if gestureTuple.0 == name {
					x = index
				}
			}
			gestureArray.remove(at: x)
			gestureDict[gesture] = gestureArray
		} else {
			gestureDict.removeValue(forKey: gesture)
		}
	}
	
	@objc(runGesture:)
	func runGesture(_ gesture: UIGestureRecognizer) {
		if let gestureArray = gestureDict[gesture] {
			for possibleClosureTuple in gestureArray {
				// println("running closure named: \(possibleClosureTuple.0)")
				switch possibleClosureTuple.1 {
				case .noParameters(let closure):
					closure()
					break
				case .withGestureParameter(let closure):
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
	func removeAction(_ control: UIControl, controlEvent: UIControlEvents) {
		if var innerDict = controlAndEventsDict[control] {
			innerDict.removeValue(forKey: controlEvent);
		}
	}
	
	func addAction(_ control: UIControl, controlEvent: UIControlEvents, closure: ActionKitClosure)
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
	func runClosureTouchDown(_ control: UIControl)
	{
		runAllClosures(control, event: .touchDown)
	}
	
	@objc(runClosureTouchDownRepeat:)
	func runClosureTouchDownRepeat(_ control: UIControl)
	{
		runAllClosures(control, event: .touchDownRepeat)
	}
	
	@objc(runClosureTouchDragInside:)
	func runClosureTouchDragInside(_ control: UIControl)
	{
		runAllClosures(control, event: .touchDragInside)
	}
	
	@objc(runClosureTouchDragOutside:)
	func runClosureTouchDragOutside(_ control: UIControl)
	{
		runAllClosures(control, event: .touchDragOutside)
	}
	
	@objc(runClosureTouchDragEnter:)
	func runClosureTouchDragEnter(_ control: UIControl)
	{
		runAllClosures(control, event: .touchDragEnter)
	}
	
	@objc(runClosureTouchDragExit:)
	func runClosureTouchDragExit(_ control: UIControl)
	{
		runAllClosures(control, event: .touchDragExit)
	}
	
	@objc(runClosureTouchUpInside:)
	func runClosureTouchUpInside(_ control: UIControl)
	{
		runAllClosures(control, event: .touchUpInside)
	}
	
	@objc(runClosureTouchUpOutside:)
	func runClosureTouchUpOutside(_ control: UIControl)
	{
		runAllClosures(control, event: .touchUpOutside)
	}
	
	@objc(runClosureTouchCancel:)
	func runClosureTouchCancel(_ control: UIControl)
	{
		runAllClosures(control, event: .touchCancel)
	}
	
	@objc(runClosureValueChanged:)
	func runClosureValueChanged(_ control: UIControl)
	{
		runAllClosures(control, event: .valueChanged)
	}
	
	@objc(runClosureEditingDidBegin:)
	func runClosureEditingDidBegin(_ control: UIControl)
	{
		runAllClosures(control, event: .editingDidBegin)
	}
	
	@objc(runClosureEditingChanged:)
	func runClosureEditingChanged(_ control: UIControl)
	{
		runAllClosures(control, event: .editingChanged)
	}
	
	@objc(runClosureEditingDidEnd:)
	func runClosureEditingDidEnd(_ control: UIControl)
	{
		runAllClosures(control, event: .editingDidEnd)
	}
	
	@objc(runClosureEditingDidEndOnExit:)
	func runClosureEditingDidEndOnExit(_ control: UIControl)
	{
		runAllClosures(control, event: .editingDidEndOnExit)
	}
	
	@objc(runClosureAllTouchEvents:)
	func runClosureAllTouchEvents(_ control: UIControl)
	{
		runAllClosures(control, event: .allTouchEvents)
	}
	
	@objc(runClosureAllEditingEvents:)
	func runClosureAllEditingEvents(_ control: UIControl)
	{
		runAllClosures(control, event: .allEditingEvents)
	}
	
	@objc(runClosureApplicationReserved:)
	func runClosureApplicationReserved(_ control: UIControl)
	{
		runAllClosures(control, event: .applicationReserved)
	}
	
	@objc(runClosureSystemReserved:)
	func runClosureSystemReserved(_ control: UIControl)
	{
		runAllClosures(control, event: .systemReserved)
	}
	
	@objc(runClosureAllEvents:)
	func runClosureAllEvents(_ control: UIControl)
	{
		runAllClosures(control, event: .allEvents)
	}
	
	
	fileprivate func runAllClosures(_ control: UIControl, event: UIControlEvents) {
		if let possibleClosures = controlAndEventsDict[control]?.filter({ $0.0.contains(event) }).map({ $0.1 }) {
			for actionKitClosure in possibleClosures {
				switch actionKitClosure {
				case .noParameters(let closure):
					closure()
					break
				case .withControlParameter(let closure):
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

//
// UIBARBUTTONITEM ACTIONS
//
extension ActionKitSingleton {
	func addBarButtonItemClosure(_ barButtonItem: UIBarButtonItem, closure: ActionKitClosure) {
		barButtonItemDict[barButtonItem] = closure
	}
	
	func removeBarButtonItemClosure(_ barButtonItem: UIBarButtonItem) {
		barButtonItemDict[barButtonItem] = nil
	}
	
	@objc(runBarButtonItem:)
	func runBarButtonItem(_ item: UIBarButtonItem)
	{
		guard let actionKitClosure = barButtonItemDict[item] else { return }
		switch actionKitClosure {
		case .noParameters(let closure):
			closure()
		case .withBarButtonItemParameter(let closure):
			closure(item)
		default:
			// Shouldn't be here
			break
		}
	}
}
