//
//  ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi on 7/17/14.
//  Copyright (c) 2014 ActionKit. All rights reserved.
//

import Foundation
import UIKit

let runClosure = "runClosure:"
let runClosureTouchUpInside = "runClosureTouchUpInside:"



class ActionKitSingleton {
    var dict: Dictionary<UIControl, ()->Void> = Dictionary()
    var dict2: Dictionary<UIControl, Dictionary<ActionKitUIControlEventsStruct, () -> Void>> = Dictionary()

    
    class var sharedInstance : ActionKitSingleton {
    struct ActionKit {
        static let instance : ActionKitSingleton = ActionKitSingleton()
        }
        return ActionKit.instance
    }

    func addClosure(control: UIControl, closure: () -> ())
    {
        dict[control] = closure
    }
    
    func addAction(control: UIControl, controlEvent: UIControlEvents, closure: () -> ())
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: controlEvent)
        if var innerDict = dict2[control] {
            innerDict[controlStruct] = closure
        }
        else {
            var newDict = Dictionary<ActionKitUIControlEventsStruct, () -> Void>()
            newDict[controlStruct] = closure
            dict2[control] = newDict
        }
    }
    
    
    @objc(runClosureTouchUpInside:)
    func runClosureTouchUpInside(control: UIControl)
    {
        let controlStruct = ActionKitUIControlEventsStruct(value: UIControlEvents.TouchUpInside)
        if let innerDict = dict2[control] {
            if let possibleClosure = innerDict[controlStruct] {
                possibleClosure()
            }
        }
    }
    
    @objc(runClosure:)
    func runClosure(control: UIControl)
    {
        if let possibleClosure = dict[control] {
            possibleClosure()
        }
    }
}

