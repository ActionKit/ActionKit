//
//  UIGestureRecognizer+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit

public protocol ActionKitGestureRecognizer {}

public extension ActionKitGestureRecognizer where Self: UIGestureRecognizer {
    init(closure: () -> ()) {
        self.init()
        _addControlEvent(closure: closure)
    }
    
    init(closureWithControl: (Self) -> ()) {
        self.init()
        addClosure(closureWithControl)
    }
    
    func addClosure(closureWithControl: (Self) -> ()) {
        _addControlEvent(closure: { [weak self] (UIControl) -> () in
            guard let strongSelf = self else { return }
            closureWithControl(strongSelf)
            })
    }
    
    func addClosure(closure: () -> ()) {
        _addControlEvent(closure: closure)
    }
}

extension UIGestureRecognizer: ActionKitGestureRecognizer {}

public extension UIGestureRecognizer {
    private struct AssociatedKeys {
        static var ActionClosure = 0
    }
    
    private var ActionClosure: ActionKitVoidClosure? {
        get { return (objc_getAssociatedObject(self, &AssociatedKeys.ActionClosure) as? ActionKitVoidClosureWrapper)?.closure }
        set { objc_setAssociatedObject(self, &AssociatedKeys.ActionClosure, ActionKitVoidClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)}
    }
    
    @objc private func runActionKitVoidClosure() {
        ActionClosure?()
    }
    
    private func _addControlEvent(closure closure: () -> ()) {
        ActionClosure = closure
        self.addTarget(self, action: #selector(UIGestureRecognizer.runActionKitVoidClosure))
    }
    
    func removeClosure() {
        ActionClosure = nil
        self.removeTarget(self, action: #selector(UIGestureRecognizer.runActionKitVoidClosure))
    }
}