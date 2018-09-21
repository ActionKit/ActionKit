//
//  UIBarButtonItem+ActionKit.swift
//  ActionKit
//
//  Created by Manue on 30/6/16.
//  Copyright © 2016 ActionKit. All rights reserved.
//

import Foundation
import UIKit

// MARK:- UIBarButtonItem actions
extension ActionKitSingleton {
    func addBarButtonItemClosure(_ barButtonItem: UIBarButtonItem, closure: ActionKitClosure) {
        controlToClosureDictionary[.barButtonItem(barButtonItem)] = closure
    }
    
    func removeBarButtonItemClosure(_ barButtonItem: UIBarButtonItem) {
        controlToClosureDictionary[.barButtonItem(barButtonItem)] = nil
    }
    
    @objc(runBarButtonItem:)
    func runBarButtonItem(_ item: UIBarButtonItem) {
        if let closure = controlToClosureDictionary[.barButtonItem(item)] {
            switch closure {
            case .noParameters(let voidClosure):
                voidClosure()
            case .withBarButtonItemParameter(let barButtonItemClosure):
                barButtonItemClosure(item)
            default:
                assertionFailure("Bar button item closure not found, nor void closure")
                break
            }
        }
    }
}

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
    
    @objc public convenience init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItem.Style = .plain, actionClosure: @escaping ActionKitVoidClosure) {
        
        self.init(image: image,
                  landscapeImagePhone: landscapeImagePhone,
                  style: style,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addClosure(actionClosure)
    }
    
    @objc public convenience init(title: String, style: UIBarButtonItem.Style = .plain, actionClosure: @escaping ActionKitVoidClosure) {
        self.init(title: title,
                  style: style,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addClosure(actionClosure)
    }
    
    @objc public convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, actionClosure: @escaping ActionKitVoidClosure) {
        self.init(barButtonSystemItem: systemItem,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addClosure(actionClosure)
    }
    
    @nonobjc
    public convenience init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItem.Style = .plain, actionClosure: @escaping ActionKitBarButtonItemClosure) {
        
        self.init(image: image,
                  landscapeImagePhone: landscapeImagePhone,
                  style: style,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addItemClosure(actionClosure)
    }
    
    @nonobjc
    public convenience init(title: String, style: UIBarButtonItem.Style = .plain, actionClosure: @escaping ActionKitBarButtonItemClosure) {
        self.init(title: title,
                  style: style,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addItemClosure(actionClosure)
    }
    
    @nonobjc
    public convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, actionClosure: @escaping ActionKitBarButtonItemClosure) {
        self.init(barButtonSystemItem: systemItem,
                  target: ActionKitSingleton.shared,
                  action: #selector(ActionKitSingleton.runBarButtonItem(_:)))
        
        addItemClosure(actionClosure)
    }

}
