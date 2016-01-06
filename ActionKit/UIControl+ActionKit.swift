//
//  UIControl+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit

extension UIControlEvents: Hashable {
    public var hashValue: Int {
        return Int(rawValue)
    }
}

public extension UIControl {
    
    func removeControlEvent(controlEvents: UIControlEvents) {
        switch controlEvents {
        case let x where x.contains(.TouchDown):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDown), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDownRepeat):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDownRepeat), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragInside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragInside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragOutside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragOutside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragEnter):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragEnter), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragExit):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragExit), forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpInside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpInside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpOutside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpOutside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchCancel):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchCancel), forControlEvents: controlEvents)
        case let x where x.contains(.ValueChanged):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureValueChanged), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidBegin):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidBegin), forControlEvents: controlEvents)
        case let x where x.contains(.EditingChanged):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingChanged), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEnd):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidEnd), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEndOnExit):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidEndOnExit), forControlEvents: controlEvents)
        case let x where x.contains(.AllTouchEvents):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllTouchEvents), forControlEvents: controlEvents)
        case let x where x.contains(.AllEditingEvents):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllEditingEvents), forControlEvents: controlEvents)
        case let x where x.contains(.ApplicationReserved):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureApplicationReserved), forControlEvents: controlEvents)
        case let x where x.contains(.SystemReserved):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureSystemReserved), forControlEvents: controlEvents)
        case let x where x.contains(.AllEvents):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllEvents), forControlEvents: controlEvents)
        default:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpInside), forControlEvents: controlEvents)
        }
        
        ActionKitSingleton.sharedInstance.removeAction(self, controlEvent: controlEvents)
        
    }
    func addControlEvent(controlEvents: UIControlEvents, closure: () -> ()) {
        
        switch controlEvents {
        case let x where x.contains(.TouchDown):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDown), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDownRepeat):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDownRepeat), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragInside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragInside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragOutside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragOutside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragEnter):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragEnter), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragExit):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchDragExit), forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpInside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpInside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpOutside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpOutside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchCancel):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchCancel), forControlEvents: controlEvents)
        case let x where x.contains(.ValueChanged):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureValueChanged), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidBegin):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidBegin), forControlEvents: controlEvents)
        case let x where x.contains(.EditingChanged):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingChanged), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEnd):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidEnd), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEndOnExit):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureEditingDidEndOnExit), forControlEvents: controlEvents)
        case let x where x.contains(.AllTouchEvents):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllTouchEvents), forControlEvents: controlEvents)
        case let x where x.contains(.AllEditingEvents):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllEditingEvents), forControlEvents: controlEvents)
        case let x where x.contains(.ApplicationReserved):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureApplicationReserved), forControlEvents: controlEvents)
        case let x where x.contains(.SystemReserved):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureSystemReserved), forControlEvents: controlEvents)
        case let x where x.contains(.AllEvents):
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureAllEvents), forControlEvents: controlEvents)
        default:
            self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosureTouchUpInside), forControlEvents: controlEvents)
        }
        
        ActionKitSingleton.sharedInstance.addAction(self, controlEvent: controlEvents, closure: closure)
    }
}