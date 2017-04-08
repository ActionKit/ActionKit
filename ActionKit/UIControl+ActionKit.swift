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
    
    public static var allValues: [UIControlEvents] {
        return [.touchDown, .touchDownRepeat, .touchDragInside, .touchDragOutside, .touchDragEnter,
                .touchDragExit, .touchUpInside, .touchUpOutside, .touchCancel, .valueChanged,
                .primaryActionTriggered, .editingDidBegin, .editingChanged, .editingDidEnd,
                .editingDidEndOnExit, .allTouchEvents, .allEditingEvents, .applicationReserved,
                .systemReserved, .allEvents]
    }
}

extension UIControl {
    
    open override func willRemoveSubview(_ subview: UIView) {
        guard subview == self else {
            super.willRemoveSubview(subview)
            return
        }
        
        for controlEvent in UIControlEvents.allValues {
            ActionKitSingleton.shared.removeAction(self, controlEvent: controlEvent)
        }
        super.willRemoveSubview(subview)
    }

    public func removeControlEvent(_ controlEvent: UIControlEvents) {
        ActionKitSingleton.shared.removeAction(self, controlEvent: controlEvent)
    }
    
    public func addControlEvent(_ controlEvent: UIControlEvents, _ controlClosure: @escaping ActionKitControlClosure) {
        self.addTarget(ActionKitSingleton.shared, action: #selector(ActionKitSingleton.runControlEventAction(_:)), for: controlEvent)
        ActionKitSingleton.shared.addAction(self, controlEvent: controlEvent, closure: .withControlParameter(controlClosure))
    }

    @nonobjc
    public func addControlEvent(_ controlEvent: UIControlEvents, _ closure: @escaping ActionKitVoidClosure) {
        self.addTarget(ActionKitSingleton.shared, action: #selector(ActionKitSingleton.runControlEventAction(_:)), for: controlEvent)
        ActionKitSingleton.shared.addAction(self, controlEvent: controlEvent, closure: .noParameters(closure))
    }
}
