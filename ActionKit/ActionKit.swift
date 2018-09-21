//
//  ActionKitv2.swift
//  ActionKit
//
//  Created by Benjamin Hendricks on 4/8/17.
//  Copyright © 2017 ActionKit. All rights reserved.
//

import Foundation
import UIKit

public typealias ActionKitVoidClosure = () -> Void
public typealias ActionKitControlClosure = (UIControl) -> Void
public typealias ActionKitGestureClosure = (UIGestureRecognizer) -> Void
public typealias ActionKitBarButtonItemClosure = (UIBarButtonItem) -> Void

public enum ActionKitClosure {
    case noParameters(ActionKitVoidClosure)
    case withControlParameter(ActionKitControlClosure)
    case withGestureParameter(ActionKitGestureClosure)
    case withBarButtonItemParameter(ActionKitBarButtonItemClosure)
}

public enum ActionKitControlType: Hashable {
    case control(UIControl, UIControl.Event)
    case gestureRecognizer(UIGestureRecognizer, String)
    case barButtonItem(UIBarButtonItem)
    
    public var hashValue: Int {
        get {
            switch self {
            case .control(let control, let controlEvent):
                return control.hashValue &* controlEvent.hashValue
            case .gestureRecognizer(let recognizer, let name):
                return recognizer.hashValue &* name.hashValue
            case .barButtonItem(let barButtonItem):
                return barButtonItem.hashValue
            }
        }
    }
}

public func ==(lhs: ActionKitControlType, rhs: ActionKitControlType) -> Bool {
    switch (lhs, rhs) {
    case (.control(let lhsControl, let lhsControlEvent), .control(let rhsControl, let rhsControlEvent)):
        return lhsControl.hashValue == rhsControl.hashValue && lhsControlEvent.hashValue == rhsControlEvent.hashValue
    case (.gestureRecognizer(let lhsRecognizer, let lhsName), .gestureRecognizer(let rhsRecognizer, let rhsName)):
        return lhsRecognizer.hashValue == rhsRecognizer.hashValue && lhsName == rhsName
    case (.barButtonItem(let lhsBarButtonItem), .barButtonItem(let rhsBarButtonItem)):
        return lhsBarButtonItem.hashValue == rhsBarButtonItem.hashValue
    default:
        return false
    }
}


public class ActionKitSingleton {
    public static let shared: ActionKitSingleton = ActionKitSingleton()
    private init() {}
    
    var controlToControlEvent = Dictionary<UIControl, Set<UIControl.Event>>()
    var gestureRecognizerToName = Dictionary<UIGestureRecognizer, Set<String>>()
    var controlToClosureDictionary = Dictionary<ActionKitControlType, ActionKitClosure>()
    
}
