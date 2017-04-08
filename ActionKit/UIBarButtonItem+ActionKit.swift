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
    public func addClosure(_ closure: @escaping ActionKitVoidClosure) {
        ActionKitSingleton.shared.addBarButtonItemClosure(self, closure: .noParameters(closure))
    }
    
    public func addItemClosure(_ itemClosure: @escaping ActionKitBarButtonItemClosure) {
        ActionKitSingleton.shared.addBarButtonItemClosure(self, closure: .withBarButtonItemParameter(itemClosure))
    }
    
    public func clearActionKit() {
        ActionKitSingleton.shared.removeBarButtonItemClosure(self)
    }
    
    public convenience init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .plain, actionClosure: @escaping ActionKitVoidClosure) {
        
        self.init(image: image,
                  landscapeImagePhone: landscapeImagePhone,
                  style: style,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addClosure(actionClosure)
    }
    
    public convenience init(title: String, style: UIBarButtonItemStyle = .plain, actionClosure: @escaping ActionKitVoidClosure) {
        self.init(title: title,
                  style: style,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addClosure(actionClosure)
    }
    
    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, actionClosure: @escaping ActionKitVoidClosure) {
        self.init(barButtonSystemItem: systemItem,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addClosure(actionClosure)
    }
    
    @nonobjc
    public convenience init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .plain, actionClosure: @escaping ActionKitBarButtonItemClosure) {
        
        self.init(image: image,
                  landscapeImagePhone: landscapeImagePhone,
                  style: style,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addItemClosure(actionClosure)
    }
    
    @nonobjc
    public convenience init(title: String, style: UIBarButtonItemStyle = .plain, actionClosure: @escaping ActionKitBarButtonItemClosure) {
        self.init(title: title,
                  style: style,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addItemClosure(actionClosure)
    }
    
    @nonobjc
    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, actionClosure: @escaping ActionKitBarButtonItemClosure) {
        self.init(barButtonSystemItem: systemItem,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addItemClosure(actionClosure)
    }

}
