//
//  UIControl+ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi on 7/17/14.
//  Copyright (c) 2014 ActionKit. All rights reserved.
//

import Foundation
import UIKit

func ==(lhs: ActionKitUIControlEventsStruct, rhs: ActionKitUIControlEventsStruct) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
struct ActionKitUIControlEventsStruct : Hashable {
    var value: UIControlEvents
    var hashValue:Int {
    get {
        switch self.value {
        case UIControlEvents.TouchDown:
            return 1
        case UIControlEvents.TouchDownRepeat:
            return 2
        case UIControlEvents.TouchDragInside:
            return 3
        case UIControlEvents.TouchDragOutside:
            return 4
        case UIControlEvents.TouchDragEnter:
            return 5
        case UIControlEvents.TouchDragExit:
            return 6
        case UIControlEvents.TouchUpInside:
            return 7
        case UIControlEvents.TouchUpOutside:
            return 8
        case UIControlEvents.TouchCancel:
            return 9
        case UIControlEvents.ValueChanged:
            return 10
        case UIControlEvents.EditingDidBegin:
            return 11
        case UIControlEvents.EditingChanged:
            return 12
        case UIControlEvents.EditingDidEnd:
            return 13
        case UIControlEvents.EditingDidEndOnExit:
            return 14
        case UIControlEvents.AllTouchEvents:
            return 15
        case UIControlEvents.AllEditingEvents:
            return 16
        case UIControlEvents.ApplicationReserved:
            return 17
        case UIControlEvents.SystemReserved:
            return 18
        case UIControlEvents.AllEvents:
            return 19
        default:
            return 20
        }
    }
    }
}

extension UIControl {
    func addControlEvent(controlEvents: UIControlEvents, closure: () -> ()) {
        self.addTarget(ActionKitSingleton.sharedInstance, action: Selector(runClosure), forControlEvents: controlEvents)
        ActionKitSingleton.sharedInstance.addClosure(self, closure)
    }
}