//
//  UIControl+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit

// MARK:- UIControl actions
extension ActionKitSingleton {
    func removeAction(_ control: UIControl, controlEvent: UIControl.Event) {
        var eventSet = control.actionKitEvents
        if eventSet?.contains(controlEvent) ?? false {
            let _ = eventSet?.remove(controlEvent)
        }
        controlToClosureDictionary[.control(control, controlEvent)] = nil
    }
    
    func addAction(_ control: UIControl, controlEvent: UIControl.Event, closure: ActionKitClosure)
    {
        let set: Set<UIControl.Event>? = controlToControlEvent[control]
        var newSet: Set<UIControl.Event>
        if let nonOptSet = set {
            newSet = nonOptSet
        } else {
            newSet = Set<UIControl.Event>()
        }
        newSet.insert(controlEvent)
        controlToControlEvent[control] = newSet
        controlToClosureDictionary[.control(control, controlEvent)] = closure
    }
    
    @objc(runControlEventAction:)
    func runControlEventAction(_ control: UIControl) {
        for controlEvent in control.actionKitEvents ?? Set<UIControl.Event>() {
            if let closure = controlToClosureDictionary[.control(control, controlEvent)] {
                switch closure {
                case .noParameters(let voidClosure):
                    voidClosure()
                case .withControlParameter(let controlClosure):
                    controlClosure(control)
                default:
                    assertionFailure("Control event closure not found, nor void closure")
                    break
                }
            }
        }
    }
}

public extension UIControl {
    var actionKitEvents: Set<UIControl.Event>? {
        get { return ActionKitSingleton.shared.controlToControlEvent[self] } set {}
    }
}

extension UIControl.Event: Hashable {
    public var hashValue: Int {
        return Int(rawValue)
    }
    
    public static var allValues: [UIControl.Event] {
        return [.touchDown, .touchDownRepeat, .touchDragInside, .touchDragOutside, .touchDragEnter,
                .touchDragExit, .touchUpInside, .touchUpOutside, .touchCancel, .valueChanged,
                .primaryActionTriggered, .editingDidBegin, .editingChanged, .editingDidEnd,
                .editingDidEndOnExit, .allTouchEvents, .allEditingEvents, .applicationReserved,
                .systemReserved, .allEvents]
    }
}

extension UIControl {
    
    open override func removeFromSuperview() {
        clearActionKit()
        super.removeFromSuperview()
    }

    public func clearActionKit() {
        let controlEvents = ActionKitSingleton.shared.controlToControlEvent[self]
        ActionKitSingleton.shared.controlToControlEvent[self] = nil
        for controlEvent in controlEvents ?? Set<UIControl.Event>() {
            ActionKitSingleton.shared.removeAction(self, controlEvent: controlEvent)
        }
    }
    
    @objc public func removeControlEvent(_ controlEvent: UIControl.Event) {
        ActionKitSingleton.shared.removeAction(self, controlEvent: controlEvent)
    }
    
    @objc public func addControlEvent(_ controlEvent: UIControl.Event, _ controlClosure: @escaping ActionKitControlClosure) {
        self.addTarget(ActionKitSingleton.shared, action: #selector(ActionKitSingleton.runControlEventAction(_:)), for: controlEvent)
        ActionKitSingleton.shared.addAction(self, controlEvent: controlEvent, closure: .withControlParameter(controlClosure))
    }

    @nonobjc
    public func addControlEvent(_ controlEvent: UIControl.Event, _ closure: @escaping ActionKitVoidClosure) {
        self.addTarget(ActionKitSingleton.shared, action: #selector(ActionKitSingleton.runControlEventAction(_:)), for: controlEvent)
        ActionKitSingleton.shared.addAction(self, controlEvent: controlEvent, closure: .noParameters(closure))
    }
}
