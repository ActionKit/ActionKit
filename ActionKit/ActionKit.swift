//
//  ActionKit.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import Foundation
import UIKit

//: ## Having an UIControl as optional input parameter for the closure
//:
//: We like to have the UIControl as input parameter in the closure, like this:
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) { (control: UIControl) in
//:         print("the control: \(control) was tapped")
//:     }
//: ```
//:
//: But unfortunately, there is a bug in the swift compiler, that prevents implicit
//: arguments in the closure. This bug will cause an error when the argument is ignored
//: implicitly. That means that if you would try to use a closure which has a argument
//: `(control: UIContol)`, without that argument like this:
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) {
//:         print("this control was tapped")
//:     }
//: ```
//:
//: Then the compiler will give an error:
//:
//: ```Contextual type for closure argument list expects 1 argument, which cannot be implicitlty ignored```
//:
//: See Chris Lattner's option on the matter (that this is a compiler bug):
//: [http://article.gmane.org/gmane.comp.lang.swift.evolution/17196/](http://article.gmane.org/gmane.comp.lang.swift.evolution/17196/)
//:
//: ### Workaround by having multiple functions
//:
//: We can workaround this bug by having multiple functions, one without the `UIControl` parameter
//: (the original) and one with the `(control: UIControl) in` parameter. The only downside is that
//: you will have to call the closure with a specific signature, so either with:
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) {
//:         ...
//:     }
//: ```
//:
//: or with:
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) { (control: UIControl) in
//:         ...
//:     }
//: ```
//:
//: but not with:
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) { aButton in
//:         ...
//:     }
//: ```
//:
//: or with
//:
//: ```swift
//:     button.addControlEvent(.TouchUpInside) { _ in
//:         ...
//:     }
//: ```
//:
//: Because `aButton` or `_` is not specific enough and the compiler will complain with:
//:
//: ```Ambiguous use of 'addControlEvent'```
//:
//: So, until this bug is solved in the Swift compiler, we will have to use **two** functions
//: for each control event, and be specific with the arguments in the closure call.
//:


internal typealias ActionKitVoidClosure = () -> Void
internal class ActionKitVoidClosureWrapper {
    var closure: ActionKitVoidClosure?
    init(_ closure: ActionKitVoidClosure?) {
        self.closure = closure
    }
}
