//
//  UIControl+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit

public protocol ActionKitControl {}

public extension ActionKitControl where Self: UIControl {
    func addControlEvent(controlEvents: UIControlEvents, closureWithControl: (Self) -> ()) {
        _addControlEvent(controlEvents, closure: { [weak self] () -> () in
            guard let strongSelf = self else { return }
            closureWithControl(strongSelf)
            })
    }
    
    func addControlEvent(controlEvents: UIControlEvents, closure: () -> ()) {
        _addControlEvent(controlEvents, closure: closure)
    }
}

extension UIControl: ActionKitControl {}

public extension UIControl {
    private struct AssociatedKeys {
        static var ControlTouchDownClosure = 0
        static var ControlTouchDownRepeatClosure = 0
        static var ControlTouchDragInsideClosure = 0
        static var ControlTouchDragOutsideClosure = 0
        static var ControlTouchDragEnterClosure = 0
        static var ControlTouchDragExitClosure = 0
        static var ControlTouchUpInsideClosure = 0
        static var ControlTouchUpOutsideClosure = 0
        static var ControlTouchCancelClosure = 0
        static var ControlValueChangedClosure = 0
        static var ControlEditingDidBeginClosure = 0
        static var ControlEditingChangedClosure = 0
        static var ControlEditingDidEndClosure = 0
        static var ControlEditingDidEndOnExitClosure = 0
        static var ControlAllTouchEventsClosure = 0
        static var ControlAllEditingEventsClosure = 0
        static var ControlApplicationReservedClosure = 0
        static var ControlSystemReservedClosure = 0
        static var ControlAllEventsClosure = 0
    }
    
    private func get(key: UnsafePointer<Void>) -> ActionKitVoidClosure? {
        return (objc_getAssociatedObject(self, key) as? ActionKitVoidClosureWrapper)?.closure
    }
    private func set(key: UnsafePointer<Void>, action: ActionKitVoidClosure?) {
        objc_setAssociatedObject(self, key, ActionKitVoidClosureWrapper(action), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
    private var TouchDownClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlTouchDownClosure) }
        set { set(&AssociatedKeys.ControlTouchDownClosure, action: newValue)}
    }
    private var TouchDownRepeatClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlTouchDownRepeatClosure) }
        set { set(&AssociatedKeys.ControlTouchDownRepeatClosure, action: newValue)}
    }
    private var TouchDragInsideClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlTouchDragInsideClosure) }
        set { set(&AssociatedKeys.ControlTouchDragInsideClosure, action: newValue)}
    }
    private var TouchDragOutsideClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlTouchDragOutsideClosure) }
        set { set(&AssociatedKeys.ControlTouchDragOutsideClosure, action: newValue)}
    }
    private var TouchDragEnterClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlTouchDragEnterClosure) }
        set { set(&AssociatedKeys.ControlTouchDragEnterClosure, action: newValue)}
    }
    private var TouchDragExitClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlTouchDragExitClosure) }
        set { set(&AssociatedKeys.ControlTouchDragExitClosure, action: newValue)}
    }
    private var TouchUpInsideClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlTouchUpInsideClosure) }
        set { set(&AssociatedKeys.ControlTouchUpInsideClosure, action: newValue)}
    }
    private var TouchUpOutsideClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlTouchUpOutsideClosure) }
        set { set(&AssociatedKeys.ControlTouchUpOutsideClosure, action: newValue)}
    }
    private var TouchCancelClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlTouchCancelClosure) }
        set { set(&AssociatedKeys.ControlTouchCancelClosure, action: newValue)}
    }
    private var ValueChangedClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlValueChangedClosure) }
        set { set(&AssociatedKeys.ControlValueChangedClosure, action: newValue)}
    }
    private var EditingDidBeginClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlEditingDidBeginClosure) }
        set { set(&AssociatedKeys.ControlEditingDidBeginClosure, action: newValue)}
    }
    private var EditingChangedClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlEditingChangedClosure) }
        set { set(&AssociatedKeys.ControlEditingChangedClosure, action: newValue)}
    }
    private var EditingDidEndClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlEditingDidEndClosure) }
        set { set(&AssociatedKeys.ControlEditingDidEndClosure, action: newValue)}
    }
    private var EditingDidEndOnExitClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlEditingDidEndOnExitClosure) }
        set { set(&AssociatedKeys.ControlEditingDidEndOnExitClosure, action: newValue)}
    }
    private var AllTouchEventsClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlAllTouchEventsClosure) }
        set { set(&AssociatedKeys.ControlAllTouchEventsClosure, action: newValue)}
    }
    private var AllEditingEventsClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlAllEditingEventsClosure) }
        set { set(&AssociatedKeys.ControlAllEditingEventsClosure, action: newValue)}
    }
    private var ApplicationReservedClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlApplicationReservedClosure) }
        set { set(&AssociatedKeys.ControlApplicationReservedClosure, action: newValue)}
    }
    private var SystemReservedClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlSystemReservedClosure) }
        set { set(&AssociatedKeys.ControlSystemReservedClosure, action: newValue)}
    }
    private var AllEventsClosure: ActionKitVoidClosure? {
        get { return get(&AssociatedKeys.ControlAllEventsClosure) }
        set { set(&AssociatedKeys.ControlAllEventsClosure, action: newValue)}
    }
    
    @objc private func runClosureTouchDown() {
        TouchDownClosure?()
    }
    @objc private func runClosureTouchDownRepeat() {
        TouchDownRepeatClosure?()
    }
    @objc private func runClosureTouchDragInside() {
        TouchDragInsideClosure?()
    }
    @objc private func runClosureTouchDragOutside() {
        TouchDragOutsideClosure?()
    }
    @objc private func runClosureTouchDragEnter() {
        TouchDragEnterClosure?()
    }
    @objc private func runClosureTouchDragExit() {
        TouchDragExitClosure?()
    }
    @objc private func runClosureTouchUpInside() {
        TouchUpInsideClosure?()
    }
    @objc private func runClosureTouchUpOutside() {
        TouchUpOutsideClosure?()
    }
    @objc private func runClosureTouchCancel() {
        TouchCancelClosure?()
    }
    @objc private func runClosureValueChanged() {
        ValueChangedClosure?()
    }
    @objc private func runClosureEditingDidBegin() {
        EditingDidBeginClosure?()
    }
    @objc private func runClosureEditingChanged() {
        EditingChangedClosure?()
    }
    @objc private func runClosureEditingDidEnd() {
        EditingDidEndClosure?()
    }
    @objc private func runClosureEditingDidEndOnExit() {
        EditingDidEndOnExitClosure?()
    }
    @objc private func runClosureAllTouchEvents() {
        AllTouchEventsClosure?()
    }
    @objc private func runClosureAllEditingEvents() {
        AllEditingEventsClosure?()
    }
    @objc private func runClosureApplicationReserved() {
        ApplicationReservedClosure?()
    }
    @objc private func runClosureSystemReserved() {
        SystemReservedClosure?()
    }
    @objc private func runClosureAllEvents() {
        AllEventsClosure?()
    }
    
    private func _addControlEvent(controlEvents: UIControlEvents, closure: ActionKitVoidClosure) {
        switch controlEvents {
        case let x where x.contains(.TouchDown):
            self.TouchDownClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureTouchDown), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDownRepeat):
            self.TouchDownRepeatClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureTouchDownRepeat), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragInside):
            self.TouchDragInsideClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureTouchDragInside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragOutside):
            self.TouchDragOutsideClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureTouchDragOutside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragEnter):
            self.TouchDragEnterClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureTouchDragEnter), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragExit):
            self.TouchDragExitClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureTouchDragExit), forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpInside):
            self.TouchUpInsideClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureTouchUpInside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpOutside):
            self.TouchUpOutsideClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureTouchUpOutside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchCancel):
            self.TouchCancelClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureTouchCancel), forControlEvents: controlEvents)
        case let x where x.contains(.ValueChanged):
            self.ValueChangedClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureValueChanged), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidBegin):
            self.EditingDidBeginClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureEditingDidBegin), forControlEvents: controlEvents)
        case let x where x.contains(.EditingChanged):
            self.EditingChangedClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureEditingChanged), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEnd):
            self.EditingDidEndClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureEditingDidEnd), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEndOnExit):
            self.EditingDidEndOnExitClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureEditingDidEndOnExit), forControlEvents: controlEvents)
        case let x where x.contains(.AllTouchEvents):
            self.AllTouchEventsClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureAllTouchEvents), forControlEvents: controlEvents)
        case let x where x.contains(.AllEditingEvents):
            self.AllEditingEventsClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureAllEditingEvents), forControlEvents: controlEvents)
        case let x where x.contains(.ApplicationReserved):
            self.ApplicationReservedClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureApplicationReserved), forControlEvents: controlEvents)
        case let x where x.contains(.SystemReserved):
            self.SystemReservedClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureSystemReserved), forControlEvents: controlEvents)
        case let x where x.contains(.AllEvents):
            self.AllEventsClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureAllEvents), forControlEvents: controlEvents)
        default:
            self.TouchUpInsideClosure = closure
            self.addTarget(self, action: #selector(UIControl.runClosureTouchUpInside), forControlEvents: controlEvents)
        }
    }
    
    func removeControlEvent(controlEvents: UIControlEvents) {
        switch controlEvents {
        case let x where x.contains(.TouchDown):
            self.TouchDownClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureTouchDown), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDownRepeat):
            self.TouchDownRepeatClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureTouchDownRepeat), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragInside):
            self.TouchDragInsideClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureTouchDragInside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragOutside):
            self.TouchDragOutsideClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureTouchDragOutside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragEnter):
            self.TouchDragEnterClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureTouchDragEnter), forControlEvents: controlEvents)
        case let x where x.contains(.TouchDragExit):
            self.TouchDragExitClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureTouchDragExit), forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpInside):
            self.TouchUpInsideClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureTouchUpInside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchUpOutside):
            self.TouchUpOutsideClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureTouchUpOutside), forControlEvents: controlEvents)
        case let x where x.contains(.TouchCancel):
            self.TouchCancelClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureTouchCancel), forControlEvents: controlEvents)
        case let x where x.contains(.ValueChanged):
            self.ValueChangedClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureValueChanged), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidBegin):
            self.EditingDidBeginClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureEditingDidBegin), forControlEvents: controlEvents)
        case let x where x.contains(.EditingChanged):
            self.EditingChangedClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureEditingChanged), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEnd):
            self.EditingDidEndClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureEditingDidEnd), forControlEvents: controlEvents)
        case let x where x.contains(.EditingDidEndOnExit):
            self.EditingDidEndOnExitClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureEditingDidEndOnExit), forControlEvents: controlEvents)
        case let x where x.contains(.AllTouchEvents):
            self.AllTouchEventsClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureAllTouchEvents), forControlEvents: controlEvents)
        case let x where x.contains(.AllEditingEvents):
            self.AllEditingEventsClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureAllEditingEvents), forControlEvents: controlEvents)
        case let x where x.contains(.ApplicationReserved):
            self.ApplicationReservedClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureApplicationReserved), forControlEvents: controlEvents)
        case let x where x.contains(.SystemReserved):
            self.SystemReservedClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureSystemReserved), forControlEvents: controlEvents)
        case let x where x.contains(.AllEvents):
            self.AllEventsClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureAllEvents), forControlEvents: controlEvents)
        default:
            self.TouchUpInsideClosure = nil
            self.removeTarget(self, action: #selector(UIControl.runClosureTouchUpInside), forControlEvents: controlEvents)
        }
    }
}