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

private extension Selector {
    
    // All 19 UIControlEvents
    static let runClosureTouchDown              = #selector(ActionKitSingleton.runClosureTouchDown(_:))
    static let runClosureTouchDownRepeat        = #selector(ActionKitSingleton.runClosureTouchDownRepeat(_:))
    static let runClosureTouchDragInside        = #selector(ActionKitSingleton.runClosureTouchDragInside(_:))
    static let runClosureTouchDragOutside       = #selector(ActionKitSingleton.runClosureTouchDragOutside(_:))
    static let runClosureTouchDragEnter         = #selector(ActionKitSingleton.runClosureTouchDragEnter(_:))
    static let runClosureTouchDragExit          = #selector(ActionKitSingleton.runClosureTouchDragExit(_:))
    static let runClosureTouchUpInside          = #selector(ActionKitSingleton.runClosureTouchUpInside(_:))
    static let runClosureTouchUpOutside         = #selector(ActionKitSingleton.runClosureTouchUpOutside(_:))
    static let runClosureTouchCancel            = #selector(ActionKitSingleton.runClosureTouchCancel(_:))
    static let runClosureValueChanged           = #selector(ActionKitSingleton.runClosureValueChanged(_:))
    static let runClosureEditingDidBegin        = #selector(ActionKitSingleton.runClosureEditingDidBegin(_:))
    static let runClosureEditingChanged         = #selector(ActionKitSingleton.runClosureEditingChanged(_:))
    static let runClosureEditingDidEnd          = #selector(ActionKitSingleton.runClosureEditingDidEnd(_:))
    static let runClosureEditingDidEndOnExit    = #selector(ActionKitSingleton.runClosureEditingDidEndOnExit(_:))
    static let runClosureAllTouchEvents         = #selector(ActionKitSingleton.runClosureAllTouchEvents(_:))
    static let runClosureAllEditingEvents       = #selector(ActionKitSingleton.runClosureAllEditingEvents(_:))
    static let runClosureApplicationReserved    = #selector(ActionKitSingleton.runClosureApplicationReserved(_:))
    static let runClosureSystemReserved         = #selector(ActionKitSingleton.runClosureSystemReserved(_:))
    static let runClosureAllEvents              = #selector(ActionKitSingleton.runClosureAllEvents(_:))

}

public extension UIControl {
    
    func removeControlEvent(controlEvents: UIControlEvents) {
        switch controlEvents {
        case let x where x.contains(.TouchDown):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDown, forControlEvents: controlEvents)
        case let x where x.contains(.TouchDownRepeat):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDownRepeat, forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragInside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragInside, forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragOutside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragOutside, forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragEnter):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragEnter, forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragExit):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragExit, forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpInside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpInside, forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpOutside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpOutside, forControlEvents: controlEvents)
        case let x where x.contains(.TouchCancel):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchCancel, forControlEvents: controlEvents)
        case let x where x.contains(.ValueChanged):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureValueChanged, forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidBegin):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidBegin, forControlEvents: controlEvents)
        case let x where x.contains(.EditingChanged):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingChanged, forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEnd):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidEnd, forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEndOnExit):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidEndOnExit, forControlEvents: controlEvents)
        case let x where x.contains(.AllTouchEvents):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllTouchEvents, forControlEvents: controlEvents)
        case let x where x.contains(.AllEditingEvents):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllEditingEvents, forControlEvents: controlEvents)
        case let x where x.contains(.ApplicationReserved):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureApplicationReserved, forControlEvents: controlEvents)
        case let x where x.contains(.SystemReserved):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureSystemReserved, forControlEvents: controlEvents)
        case let x where x.contains(.AllEvents):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllEvents, forControlEvents: controlEvents)
        default:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpInside, forControlEvents: controlEvents)
        }
        
        ActionKitSingleton.sharedInstance.removeAction(self, controlEvent: controlEvents)
        
    }
    
    func addControlEvent(controlEvents: UIControlEvents, closure: () -> ()) {
        self.addControlEvent(controlEvents, actionKitClosure: .NoParameters(closure))
    }
    
    func addControlEvent(controlEvents: UIControlEvents, closureWithControl: (UIControl) -> ()) {
        self.addControlEvent(controlEvents, actionKitClosure: .WithControlParameter(closureWithControl))
    }
    
    private func addControlEvent(controlEvents: UIControlEvents, actionKitClosure: ActionKitClosure) {

        switch controlEvents {
        case let x where x.contains(.TouchDown):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDown, forControlEvents: controlEvents)
        case let x where x.contains(.TouchDownRepeat):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDownRepeat, forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragInside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragInside, forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragOutside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragOutside, forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragEnter):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragEnter, forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragExit):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragExit, forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpInside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpInside, forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpOutside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpOutside, forControlEvents: controlEvents)
        case let x where x.contains(.TouchCancel):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchCancel, forControlEvents: controlEvents)
        case let x where x.contains(.ValueChanged):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureValueChanged, forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidBegin):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidBegin, forControlEvents: controlEvents)
        case let x where x.contains(.EditingChanged):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingChanged, forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEnd):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidEnd, forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEndOnExit):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidEndOnExit, forControlEvents: controlEvents)
        case let x where x.contains(.AllTouchEvents):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllTouchEvents, forControlEvents: controlEvents)
        case let x where x.contains(.AllEditingEvents):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllEditingEvents, forControlEvents: controlEvents)
        case let x where x.contains(.ApplicationReserved):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureApplicationReserved, forControlEvents: controlEvents)
        case let x where x.contains(.SystemReserved):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureSystemReserved, forControlEvents: controlEvents)
        case let x where x.contains(.AllEvents):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllEvents, forControlEvents: controlEvents)
        default:
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpInside, forControlEvents: controlEvents)
        }
        
        ActionKitSingleton.sharedInstance.addAction(self, controlEvent: controlEvents, closure: actionKitClosure)
    }
}