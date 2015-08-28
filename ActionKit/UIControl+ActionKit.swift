//
//  UIControl+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit

func ==(lhs: ActionKitUIControlEventsStruct, rhs: ActionKitUIControlEventsStruct) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
struct ActionKitUIControlEventsStruct : Hashable {
    var value: UIControlEvents
    var hashValue:Int {
		get {
			switch self.value {
			case UIControlEvents.TouchDown:
				return 1
			case UIControlEvents.TouchDownRepeat:
				return 2
			case UIControlEvents.TouchDragInside:
				return 3
			case UIControlEvents.TouchDragOutside:
				return 4
			case UIControlEvents.TouchDragEnter:
				return 5
			case UIControlEvents.TouchDragExit:
				return 6
			case UIControlEvents.TouchUpInside:
				return 7
			case UIControlEvents.TouchUpOutside:
				return 8
			case UIControlEvents.TouchCancel:
				return 9
			case UIControlEvents.ValueChanged:
				return 10
			case UIControlEvents.EditingDidBegin:
				return 11
			case UIControlEvents.EditingChanged:
				return 12
			case UIControlEvents.EditingDidEnd:
				return 13
			case UIControlEvents.EditingDidEndOnExit:
				return 14
			case UIControlEvents.AllTouchEvents:
				return 15
			case UIControlEvents.AllEditingEvents:
				return 16
			case UIControlEvents.ApplicationReserved:
				return 17
			case UIControlEvents.SystemReserved:
				return 18
			case UIControlEvents.AllEvents:
				return 19
			default:
				return 20
			}
		}
    }
}

public extension UIControl {
    
    func removeControlEvent(controlEvents: UIControlEvents) {
        switch controlEvents {
        case UIControlEvents.TouchDown:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDown), forControlEvents: controlEvents)
        case UIControlEvents.TouchDownRepeat:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDownRepeat), forControlEvents: controlEvents)
        case UIControlEvents.TouchDragInside:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragInside), forControlEvents: controlEvents)
        case UIControlEvents.TouchDragOutside:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragOutside), forControlEvents: controlEvents)
        case UIControlEvents.TouchDragEnter:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragEnter), forControlEvents: controlEvents)
        case UIControlEvents.TouchDragExit:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragExit), forControlEvents: controlEvents)
        case UIControlEvents.TouchUpInside:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpInside), forControlEvents: controlEvents)
        case UIControlEvents.TouchUpOutside:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpOutside), forControlEvents: controlEvents)
        case UIControlEvents.TouchCancel:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchCancel), forControlEvents: controlEvents)
        case UIControlEvents.ValueChanged:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureValueChanged), forControlEvents: controlEvents)
        case UIControlEvents.EditingDidBegin:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidBegin), forControlEvents: controlEvents)
        case UIControlEvents.EditingChanged:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingChanged), forControlEvents: controlEvents)
        case UIControlEvents.EditingDidEnd:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidEnd), forControlEvents: controlEvents)
        case UIControlEvents.EditingDidEndOnExit:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidEndOnExit), forControlEvents: controlEvents)
        case UIControlEvents.AllTouchEvents:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllTouchEvents), forControlEvents: controlEvents)
        case UIControlEvents.AllEditingEvents:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllEditingEvents), forControlEvents: controlEvents)
        case UIControlEvents.ApplicationReserved:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureApplicationReserved), forControlEvents: controlEvents)
        case UIControlEvents.SystemReserved:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureSystemReserved), forControlEvents: controlEvents)
        case UIControlEvents.AllEvents:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllEvents), forControlEvents: controlEvents)
        default:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpInside), forControlEvents: controlEvents)
        }

        ActionKitSingleton.sharedInstance.removeAction(self, controlEvent: controlEvents)

    }
    func addControlEvent(controlEvents: UIControlEvents, closure: () -> ()) {
        
        switch controlEvents {
        case UIControlEvents.TouchDown:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDown), forControlEvents: controlEvents)
        case UIControlEvents.TouchDownRepeat:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDownRepeat), forControlEvents: controlEvents)
        case UIControlEvents.TouchDragInside:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragInside), forControlEvents: controlEvents)
        case UIControlEvents.TouchDragOutside:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragOutside), forControlEvents: controlEvents)
        case UIControlEvents.TouchDragEnter:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragEnter), forControlEvents: controlEvents)
        case UIControlEvents.TouchDragExit:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragExit), forControlEvents: controlEvents)
        case UIControlEvents.TouchUpInside:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpInside), forControlEvents: controlEvents)
        case UIControlEvents.TouchUpOutside:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpOutside), forControlEvents: controlEvents)
        case UIControlEvents.TouchCancel:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchCancel), forControlEvents: controlEvents)
        case UIControlEvents.ValueChanged:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureValueChanged), forControlEvents: controlEvents)
        case UIControlEvents.EditingDidBegin:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidBegin), forControlEvents: controlEvents)
        case UIControlEvents.EditingChanged:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingChanged), forControlEvents: controlEvents)
        case UIControlEvents.EditingDidEnd:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidEnd), forControlEvents: controlEvents)
        case UIControlEvents.EditingDidEndOnExit:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidEndOnExit), forControlEvents: controlEvents)
        case UIControlEvents.AllTouchEvents:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllTouchEvents), forControlEvents: controlEvents)
        case UIControlEvents.AllEditingEvents:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllEditingEvents), forControlEvents: controlEvents)
        case UIControlEvents.ApplicationReserved:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureApplicationReserved), forControlEvents: controlEvents)
        case UIControlEvents.SystemReserved:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureSystemReserved), forControlEvents: controlEvents)
        case UIControlEvents.AllEvents:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllEvents), forControlEvents: controlEvents)
        default:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpInside), forControlEvents: controlEvents)
        }
        
        ActionKitSingleton.sharedInstance.addAction(self, controlEvent: controlEvents, closure: closure)
    }
}