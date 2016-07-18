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
    static let runClosureTouchDown              = #selector(ActionKitSingleton.runClosureTouchDown(control:))
    static let runClosureTouchDownRepeat        = #selector(ActionKitSingleton.runClosureTouchDownRepeat(control:))
    static let runClosureTouchDragInside        = #selector(ActionKitSingleton.runClosureTouchDragInside(control:))
    static let runClosureTouchDragOutside       = #selector(ActionKitSingleton.runClosureTouchDragOutside(control:))
    static let runClosureTouchDragEnter         = #selector(ActionKitSingleton.runClosureTouchDragEnter(control:))
    static let runClosureTouchDragExit          = #selector(ActionKitSingleton.runClosureTouchDragExit(control:))
    static let runClosureTouchUpInside          = #selector(ActionKitSingleton.runClosureTouchUpInside(control:))
    static let runClosureTouchUpOutside         = #selector(ActionKitSingleton.runClosureTouchUpOutside(control:))
    static let runClosureTouchCancel            = #selector(ActionKitSingleton.runClosureTouchCancel(control:))
    static let runClosureValueChanged           = #selector(ActionKitSingleton.runClosureValueChanged(control:))
    static let runClosureEditingDidBegin        = #selector(ActionKitSingleton.runClosureEditingDidBegin(control:))
    static let runClosureEditingChanged         = #selector(ActionKitSingleton.runClosureEditingChanged(control:))
    static let runClosureEditingDidEnd          = #selector(ActionKitSingleton.runClosureEditingDidEnd(control:))
    static let runClosureEditingDidEndOnExit    = #selector(ActionKitSingleton.runClosureEditingDidEndOnExit(control:))
    static let runClosureAllTouchEvents         = #selector(ActionKitSingleton.runClosureAllTouchEvents(control:))
    static let runClosureAllEditingEvents       = #selector(ActionKitSingleton.runClosureAllEditingEvents(control:))
    static let runClosureApplicationReserved    = #selector(ActionKitSingleton.runClosureApplicationReserved(control:))
    static let runClosureSystemReserved         = #selector(ActionKitSingleton.runClosureSystemReserved(control:))
    static let runClosureAllEvents              = #selector(ActionKitSingleton.runClosureAllEvents(control:))

}

public protocol ActionKitControl {}

public extension ActionKitControl where Self: UIControl {
    
    typealias SpecificControlClosure = (Self) -> ()

    internal func castedActionKitControlClosure(control: Self, closure: SpecificControlClosure) -> ActionKitClosure {
        return ActionKitClosure.WithControlParameter( { (ctrl: UIControl) in
            closure(control)
        })
    }
    
    func addControlEvent(controlEvents: UIControlEvents, closureWithControl: SpecificControlClosure) {
        let akClosure = castedActionKitControlClosure(control: self, closure: closureWithControl)
        self.addControlEvent(controlEvents: controlEvents, actionKitClosure: akClosure)
    }
}

extension UIControl: ActionKitControl {}

public extension UIControl {
    
    func removeControlEvent(controlEvents: UIControlEvents) {
        switch controlEvents {
        case let x where x.contains(.touchDown):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDown, for: controlEvents)
        case let x where x.contains(.touchDownRepeat):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDownRepeat, for: controlEvents)
        case let x where x.contains(.touchDragInside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragInside, for: controlEvents)
        case let x where x.contains(.touchDragOutside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragOutside, for: controlEvents)
        case let x where x.contains(.touchDragEnter):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragEnter, for: controlEvents)
        case let x where x.contains(.touchDragExit):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragExit, for: controlEvents)
        case let x where x.contains(.touchUpInside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpInside, for: controlEvents)
        case let x where x.contains(.touchUpOutside):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpOutside, for: controlEvents)
        case let x where x.contains(.touchCancel):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchCancel, for: controlEvents)
        case let x where x.contains(.valueChanged):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureValueChanged, for: controlEvents)
        case let x where x.contains(.editingDidBegin):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidBegin, for: controlEvents)
        case let x where x.contains(.editingChanged):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingChanged, for: controlEvents)
        case let x where x.contains(.editingDidEnd):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidEnd, for: controlEvents)
        case let x where x.contains(.editingDidEndOnExit):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidEndOnExit, for: controlEvents)
        case let x where x.contains(.allTouchEvents):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllTouchEvents, for: controlEvents)
        case let x where x.contains(.allEditingEvents):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllEditingEvents, for: controlEvents)
        case let x where x.contains(.applicationReserved):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureApplicationReserved, for: controlEvents)
        case let x where x.contains(.systemReserved):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureSystemReserved, for: controlEvents)
        case let x where x.contains(.allEvents):
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllEvents, for: controlEvents)
        default:
            self.removeTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpInside, for: controlEvents)
        }
        
        ActionKitSingleton.sharedInstance.removeAction(control: self, controlEvent: controlEvents)
        
    }
    
    func addControlEvent(controlEvents: UIControlEvents, closure: () -> ()) {
        self.addControlEvent(controlEvents: controlEvents, actionKitClosure: .NoParameters(closure))
    }
    
    private func addControlEvent(controlEvents: UIControlEvents, actionKitClosure: ActionKitClosure) {

        switch controlEvents {
        case let x where x.contains(.touchDown):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDown, for: controlEvents)
        case let x where x.contains(.touchDownRepeat):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDownRepeat, for: controlEvents)
        case let x where x.contains(.touchDragInside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragInside, for: controlEvents)
        case let x where x.contains(.touchDragOutside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragOutside, for: controlEvents)
        case let x where x.contains(.touchDragEnter):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragEnter, for: controlEvents)
        case let x where x.contains(.touchDragExit):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchDragExit, for: controlEvents)
        case let x where x.contains(.touchUpInside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpInside, for: controlEvents)
        case let x where x.contains(.touchUpOutside):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpOutside, for: controlEvents)
        case let x where x.contains(.touchCancel):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchCancel, for: controlEvents)
        case let x where x.contains(.valueChanged):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureValueChanged, for: controlEvents)
        case let x where x.contains(.editingDidBegin):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidBegin, for: controlEvents)
        case let x where x.contains(.editingChanged):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingChanged, for: controlEvents)
        case let x where x.contains(.editingDidEnd):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidEnd, for: controlEvents)
        case let x where x.contains(.editingDidEndOnExit):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureEditingDidEndOnExit, for: controlEvents)
        case let x where x.contains(.allTouchEvents):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllTouchEvents, for: controlEvents)
        case let x where x.contains(.allEditingEvents):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllEditingEvents, for: controlEvents)
        case let x where x.contains(.applicationReserved):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureApplicationReserved, for: controlEvents)
        case let x where x.contains(.systemReserved):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureSystemReserved, for: controlEvents)
        case let x where x.contains(.allEvents):
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureAllEvents, for: controlEvents)
        default:
            self.addTarget(ActionKitSingleton.sharedInstance, action: .runClosureTouchUpInside, for: controlEvents)
        }
        
        ActionKitSingleton.sharedInstance.addAction(control: self, controlEvent: controlEvents, closure: actionKitClosure)
    }
}
