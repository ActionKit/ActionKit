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
        control.removeTarget(ActionKitSingleton.shared, action: ActionKitSingleton.selectorForControlEvent(controlEvent), for: controlEvent)
        controlToClosureDictionary[.control(control, controlEvent)] = nil
    }
    
    func addAction(_ control: UIControl, controlEvent: UIControl.Event, closure: ActionKitClosure) {
        controlToClosureDictionary[.control(control, controlEvent)] = closure
    }
    
    func runControlEventAction(_ control: UIControl, controlEvent: UIControl.Event) {
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
    
    @objc(runTouchDownAction:)
    func runTouchDownAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .touchDown)
    }
    
    @objc(runTouchDownRepeatAction:)
    func runTouchDownRepeatAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .touchDownRepeat)
    }
    
    @objc(runTouchDagInsideAction:)
    func runTouchDragInsideAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .touchDragInside)
    }
    
    @objc(runTouchDragOutsideAction:)
    func runTouchDragOutsideAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .touchDragOutside)
    }
    
    @objc(runTouchDragEnterAction:)
    func runTouchDragEnterAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .touchDragEnter)
    }
    
    @objc(runTouchDragExitAction:)
    func runTouchDragExitAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .touchDragExit)
    }
    
    @objc(runTouchUpInsideAction:)
    func runTouchUpInsideAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .touchUpInside)
    }
    
    @objc(runTouchUpOutsideAction:)
    func runTouchUpOutsideAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .touchUpOutside)
    }
    
    @objc(runTouchCancelAction:)
    func runTouchCancelAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .touchCancel)
    }
    
    @objc(runValueChangedAction:)
    func runValueChangedAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .valueChanged)
    }

    @objc(runPrimaryActionTriggeredAction:)
    func runPrimaryActionTriggeredAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .primaryActionTriggered)
    }
    
    @objc(runEditingDidBeginAction:)
    func runEditingDidBeginAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .editingDidBegin)
    }
    
    @objc(runEditingChangedAction:)
    func runEditingChangedAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .editingChanged)
    }
    
    @objc(runEditingDidEndAction:)
    func runEditingDidEndAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .editingDidEnd)
    }
    
    @objc(runEditingDidEndOnExit:)
    func runEditingDidEndOnExitAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .editingDidEndOnExit)
    }
    
    @objc(runAllTouchEvents:)
    func runAllTouchEventsAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .allTouchEvents)
    }
    
    @objc(runAllEditingEventsAction:)
    func runAllEditingEventsAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .allEditingEvents)
    }
    
    @objc(runApplicationReservedAction:)
    func runApplicationReservedAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .applicationReserved)
    }
    
    @objc(runSystemReservedAction:)
    func runSystemReservedAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .systemReserved)
    }
    
    @objc(runAllEventsAction:)
    func runAllEventsAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .allEvents)
    }
    
    @objc(runDefaultAction:)
    func runDefaultAction(_ control: UIControl) {
        runControlEventAction(control, controlEvent: .init(rawValue: 0))
    }
    
    static fileprivate func selectorForControlEvent(_ controlEvent: UIControl.Event) -> Selector {
        switch controlEvent {
        case .touchDown:
            return #selector(ActionKitSingleton.runTouchDownAction(_:))
        case .touchDownRepeat:
            return #selector(ActionKitSingleton.runTouchDownRepeatAction(_:))
        case .touchDragInside:
            return #selector(ActionKitSingleton.runTouchDragInsideAction(_:))
        case .touchDragOutside:
            return #selector(ActionKitSingleton.runTouchDragOutsideAction(_:))
        case .touchDragEnter:
            return #selector(ActionKitSingleton.runTouchDragEnterAction(_:))
        case .touchDragExit:
            return #selector(ActionKitSingleton.runTouchDragExitAction(_:))
        case .touchUpInside:
            return #selector(ActionKitSingleton.runTouchUpInsideAction(_:))
        case .touchUpOutside:
            return #selector(ActionKitSingleton.runTouchUpOutsideAction(_:))
        case .touchCancel:
            return #selector(ActionKitSingleton.runTouchCancelAction(_:))
        case .valueChanged:
            return #selector(ActionKitSingleton.runValueChangedAction(_:))
        case .primaryActionTriggered:
            return #selector(ActionKitSingleton.runPrimaryActionTriggeredAction(_:))
        case .editingDidBegin:
            return #selector(ActionKitSingleton.runEditingDidBeginAction(_:))
        case .editingChanged:
            return #selector(ActionKitSingleton.runEditingChangedAction(_:))
        case .editingDidEnd:
            return #selector(ActionKitSingleton.runEditingDidEndAction(_:))
        case .editingDidEndOnExit:
            return #selector(ActionKitSingleton.runEditingDidEndOnExitAction(_:))
        case .allTouchEvents:
            return #selector(ActionKitSingleton.runAllTouchEventsAction(_:))
        case .allEditingEvents:
            return #selector(ActionKitSingleton.runAllEditingEventsAction(_:))
        case .applicationReserved:
            return #selector(ActionKitSingleton.runApplicationReservedAction(_:))
        case .systemReserved:
            return #selector(ActionKitSingleton.runSystemReservedAction(_:))
        case .allEvents:
            return #selector(ActionKitSingleton.runAllEventsAction(_:))
        default:
            return #selector(ActionKitSingleton.runDefaultAction(_:))
        }
    }
}

extension UIControl.Event: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
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
        for eventType in UIControl.Event.allValues {
            let closure = ActionKitSingleton.shared.controlToClosureDictionary[.control(self, eventType)]
            if closure != nil {
                ActionKitSingleton.shared.removeAction(self, controlEvent: eventType)
            }
        }
    }
    
    @objc public func removeControlEvent(_ controlEvent: UIControl.Event) {
        ActionKitSingleton.shared.removeAction(self, controlEvent: controlEvent)
    }
    
    
    
    @objc public func addControlEvent(_ controlEvent: UIControl.Event, _ controlClosure: @escaping ActionKitControlClosure) {
        self.addTarget(ActionKitSingleton.shared, action: ActionKitSingleton.selectorForControlEvent(controlEvent), for: controlEvent)
        ActionKitSingleton.shared.addAction(self, controlEvent: controlEvent, closure: .withControlParameter(controlClosure))
    }

    @nonobjc
    public func addControlEvent(_ controlEvent: UIControl.Event, _ closure: @escaping ActionKitVoidClosure) {
        self.addTarget(ActionKitSingleton.shared, action: ActionKitSingleton.selectorForControlEvent(controlEvent), for: controlEvent)
        ActionKitSingleton.shared.addAction(self, controlEvent: controlEvent, closure: .noParameters(closure))
    }
}
