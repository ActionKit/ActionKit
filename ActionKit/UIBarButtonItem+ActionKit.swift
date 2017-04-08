//
//  UIBarButtonItem+ActionKit.swift
//  ActionKit
//
//  Created by Manue on 30/6/16.
//  Copyright © 2016 ActionKit. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    public func addClosure(_ closure: @escaping () -> ()) {
        ActionKitSingleton.shared.addBarButtonItemClosure(self, closure: .noParameters(closure))
    }
    
    public func addItemClosure(_ itemClosure: @escaping (UIBarButtonItem) -> ()) {
        ActionKitSingleton.shared.addBarButtonItemClosure(self, closure: .withBarButtonItemParameter(itemClosure))
    }
}
