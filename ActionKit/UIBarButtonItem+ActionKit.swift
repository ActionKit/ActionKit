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

/** 
 Extension to provide convenience initializers to use closures instead of target/actions.
*/
public extension UIBarButtonItem {
	
	/** 
	Initializes a new item using the specified image and other properties.
	
	- parameter image: The images displayed on the bar are derived from this image. If this image is too large to fit on the bar, it is scaled to fit. Typically, the size of a toolbar and navigation bar image is 20 x 20 points. The alpha values in the source image are used to create the images—opaque values are ignored.
	- parameter landscapeImagePhone: The style of the item. One of the constants defined in UIBarButtonItemStyle. nil by default
	- parameter style: The style of the item. One of the constants defined in UIBarButtonItemStyle. (.Plain by default)
	- parameter closure: The closure to be called when the button is tapped
	- returns: Newly initialized item with the specified properties.
	*/
	convenience init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .Plain, closure: () -> Void) {
		
		self.init(image: image,
		          landscapeImagePhone: landscapeImagePhone,
		          style: style,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		ActionKitSingleton.sharedInstance.addBarButtonItemClosure(self, closure: closure)
	}
	
	/**
	Initializes a new item using the specified title and other properties.
	
	- parameter title: The item’s title.
	- parameter style: The style of the item. One of the constants defined in UIBarButtonItemStyle. (.Plain by default)
	- parameter closure: The closure to be called when the button is tapped
	- returns: Newly initialized item with the specified properties.
	*/
	convenience init(title: String, style: UIBarButtonItemStyle = .Plain, closure: () -> Void) {
		self.init(title: title,
		          style: style,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		ActionKitSingleton.sharedInstance.addBarButtonItemClosure(self, closure: closure)
	}
	
	/**
	Initializes a new item containing the specified system item.
	
	- parameter systemItem: The system item to use as the first item on the bar. One of the constants defined in UIBarButtonSystemItem.
	- parameter closure: The closure to be called when the button is tapped
	- returns: Newly initialized item with the specified properties.
	*/
	convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, closure: () -> Void) {
		self.init(barButtonSystemItem: systemItem,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		ActionKitSingleton.sharedInstance.addBarButtonItemClosure(self, closure: closure)
	}
	
	/** 
	The closure to be called when the button is tapped.
	*/
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
