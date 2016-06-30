//
//  UIBarButtonItem+ActionKit.swift
//  ActionKit
//
//  Created by Manue on 30/6/16.
//  Copyright © 2016 ActionKit. All rights reserved.
//

import Foundation
import UIKit

private extension Selector {
	static let runBarButtonItem = #selector(ActionKitSingleton.runBarButtonItem(_:))
}

public extension UIBarButtonItem {
	
	convenience init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .Plain, closure: () -> Void) {
		
		self.init(image: image,
		          landscapeImagePhone: landscapeImagePhone,
		          style: style,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		ActionKitSingleton.sharedInstance.addBarButtonItemClosure(self, closure: closure)
	}
	
	convenience init(title: String, style: UIBarButtonItemStyle = .Plain, closure: () -> Void) {
		self.init(title: title,
		          style: style,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		ActionKitSingleton.sharedInstance.addBarButtonItemClosure(self, closure: closure)
	}
	
	convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, closure: () -> Void) {
		self.init(barButtonSystemItem: systemItem,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		ActionKitSingleton.sharedInstance.addBarButtonItemClosure(self, closure: closure)
	}
	
	var closure: (() -> Void)? {
		get {
			return ActionKitSingleton.sharedInstance.barButtonItemClosure(self)
		}
		
		set {
			if let closure = newValue {
				ActionKitSingleton.sharedInstance.addBarButtonItemClosure(self, closure: closure)
			}
			
			else {
				ActionKitSingleton.sharedInstance.removeBarButtonItemClosure(self)
			}
		}
	}
	
}
