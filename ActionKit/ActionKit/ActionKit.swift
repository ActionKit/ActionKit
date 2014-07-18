//
//  ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi on 7/17/14.
//  Copyright (c) 2014 ActionKit. All rights reserved.
//

import Foundation
import UIKit

var static_sharedInstance: ActionKitSingleton? = nil

class ActionKitSingleton {
    var dict: Dictionary<UIControl, ()->Void> = Dictionary()
    
    class func sharedInstance() -> ActionKitSingleton {
        if !static_sharedInstance {
            static_sharedInstance = ActionKitSingleton()
        }
        return static_sharedInstance!
    }
    
    func addAction(control: UIControl, closure: () -> ())
    {
        dict[control] = closure
    }
    @objc(runClosure:)
    func runClosure(control: UIControl)
    {
        if let possibleClosure = dict[control] {
            possibleClosure()
        }
    }
}

//class ActionKitSingleton {
//    class var sharedInstance : ActionKitSingleton {
//    struct ActionKit {
//        static let instance : ActionKitSingleton = ActionKitSingleton()
//        }
//        return ActionKit.instance
//    }
//    var dict: Dictionary<UIControl, ()->Void> = Dictionary()
//    func addAction(control: UIControl, closure: () -> ())
//    {
//        dict[control] = closure
//    }
//    @objc(runClosure:)
//    func runClosure(control: UIControl)
//    {
//        if let possibleClosure = dict[control] {
//            possibleClosure()
//        }
//    }
//
//}