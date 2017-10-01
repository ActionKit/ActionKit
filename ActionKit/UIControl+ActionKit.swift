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
    func removeAction(_ control: UIControl, controlEvent: UIControlEvents) {
        var eventSet = control.actionKitEvents
        if eventSet?.contains(controlEvent) ?? false {
            let _ = eventSet?.remove(controlEvent)
        }
        controlToClosureDictionary[.control(control, controlEvent)] = nil
    }
    
    func addAction(_ control: UIControl, controlEvent: UIControlEvents, closure: ActionKitClosure)
    {
        let set: Set<UIControlEvents>? = controlToControlEvent[control]
        var newSet: Set<UIControlEvents>
        if let nonOptSet = set {
            newSet = nonOptSet
        } else {
            newSet = Set<UIControlEvents>()
        }
        newSet.insert(controlEvent)
        controlToControlEvent[control] = newSet
        controlToClosureDictionary[.control(control, controlEvent)] = closure
    }
    
    @objc(runControlEventAction:)
    func runControlEventAction(_ control: UIControl) {
        for controlEvent in control.actionKitEvents ?? Set<UIControlEvents>() {
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
    var actionKitEvents: Set<UIControlEvents>? {
        get { return ActionKitSingleton.shared.controlToControlEvent[self] } set {}
    }
}

extension UIControlEvents: Hashable {
    public var hashValue: Int {
        return Int(rawValue)
    }
    
    public static var allValues: [UIControlEvents] {
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
        for controlEvent in controlEvents ?? Set<UIControlEvents>() {
            ActionKitSingleton.shared.removeAction(self, controlEvent: controlEvent)
        }
    }
    
    @objc public func removeControlEvent(_ controlEvent: UIControlEvents) {
        ActionKitSingleton.shared.removeAction(self, controlEvent: controlEvent)
    }
    
    @objc public func addControlEvent(_ controlEvent: UIControlEvents, _ controlClosure: @escaping ActionKitControlClosure) {
        self.addTarget(ActionKitSingleton.shared, action: #selector(ActionKitSingleton.runControlEventAction(_:)), for: controlEvent)
        ActionKitSingleton.shared.addAction(self, controlEvent: controlEvent, closure: .withControlParameter(controlClosure))
    }

    @nonobjc
    public func addControlEvent(_ controlEvent: UIControlEvents, _ closure: @escaping ActionKitVoidClosure) {
        self.addTarget(ActionKitSingleton.shared, action: #selector(ActionKitSingleton.runControlEventAction(_:)), for: controlEvent)
        ActionKitSingleton.shared.addAction(self, controlEvent: controlEvent, closure: .noParameters(closure))
    }
}
