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
	
	// MARK: Void
	/** 
	Initializes a new item using the specified image and other properties.
	
	- parameter image: The images displayed on the bar are derived from this image. If this image is too large to fit on the bar, it is scaled to fit. Typically, the size of a toolbar and navigation bar image is 20 x 20 points. The alpha values in the source image are used to create the images—opaque values are ignored.
	- parameter landscapeImagePhone: The style of the item. One of the constants defined in UIBarButtonItemStyle. nil by default
	- parameter style: The style of the item. One of the constants defined in UIBarButtonItemStyle. (.Plain by default)
	- parameter actionClosure: The closure to be called when the button is tapped
	- returns: Newly initialized item with the specified properties.
	*/
	convenience init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .plain, actionClosure: @escaping () -> Void) {
		
		self.init(image: image,
		          landscapeImagePhone: landscapeImagePhone,
		          style: style,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		addActionClosure(actionClosure)
	}
	
	/**
	Initializes a new item using the specified title and other properties.
	
	- parameter title: The item’s title.
	- parameter style: The style of the item. One of the constants defined in UIBarButtonItemStyle. (.Plain by default)
	- parameter actionClosure: The closure to be called when the button is tapped
	- returns: Newly initialized item with the specified properties.
	*/
	convenience init(title: String, style: UIBarButtonItemStyle = .plain, actionClosure: @escaping () -> Void) {
		self.init(title: title,
		          style: style,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		addActionClosure(actionClosure)
	}
	
	/**
	Initializes a new item containing the specified system item.
	
	- parameter systemItem: The system item to use as the first item on the bar. One of the constants defined in UIBarButtonSystemItem.
	- parameter actionClosure: The closure to be called when the button is tapped
	- returns: Newly initialized item with the specified properties.
	*/
	convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, actionClosure: @escaping () -> Void) {
		self.init(barButtonSystemItem: systemItem,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		addActionClosure(actionClosure)
	}
	
	/** 
	Set a new closure to be called when the button is tapped. 
	**NOTE**: The old closure will be removed and not called anymore
	*/
	fileprivate func addActionClosure(_ actionClosure: @escaping () -> Void) {
		ActionKitSingleton.sharedInstance.addBarButtonItemClosure(self, closure: .noParameters(actionClosure))
	}
	
	// MARK: Parameter
	/**
	Initializes a new item using the specified image and other properties.
	
	- parameter image: The images displayed on the bar are derived from this image. If this image is too large to fit on the bar, it is scaled to fit. Typically, the size of a toolbar and navigation bar image is 20 x 20 points. The alpha values in the source image are used to create the images—opaque values are ignored.
	- parameter landscapeImagePhone: The style of the item. One of the constants defined in UIBarButtonItemStyle. nil by default
	- parameter style: The style of the item. One of the constants defined in UIBarButtonItemStyle. (.Plain by default)
	- parameter actionClosure: The closure to be called when the button is tapped
	- returns: Newly initialized item with the specified properties.
	*/
	convenience init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .plain, closureWithItem: @escaping (UIBarButtonItem) -> Void) {
		
		self.init(image: image,
		          landscapeImagePhone: landscapeImagePhone,
		          style: style,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		addActionClosure(closureWithItem)
	}
	
	/**
	Initializes a new item using the specified title and other properties.
	
	- parameter title: The item’s title.
	- parameter style: The style of the item. One of the constants defined in UIBarButtonItemStyle. (.Plain by default)
	- parameter actionClosure: The closure to be called when the button is tapped
	- returns: Newly initialized item with the specified properties.
	*/
	convenience init(title: String, style: UIBarButtonItemStyle = .plain, closureWithItem: @escaping (UIBarButtonItem) -> Void) {
		self.init(title: title,
		          style: style,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		addActionClosure(closureWithItem)
	}
	
	/**
	Initializes a new item containing the specified system item.
	
	- parameter systemItem: The system item to use as the first item on the bar. One of the constants defined in UIBarButtonSystemItem.
	- parameter actionClosure: The closure to be called when the button is tapped
	- returns: Newly initialized item with the specified properties.
	*/
	convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, closureWithItem: @escaping (UIBarButtonItem) -> Void) {
		self.init(barButtonSystemItem: systemItem,
		          target: ActionKitSingleton.sharedInstance,
		          action: .runBarButtonItem)
		
		addActionClosure(closureWithItem)
	}
	
	/**
	Set a new closure to be called when the button is tapped.
	**NOTE**: The old closure will be removed and not called anymore
	*/
	fileprivate func addActionClosure(_ actionClosure: @escaping (UIBarButtonItem) -> Void) {
		ActionKitSingleton.sharedInstance.addBarButtonItemClosure(self, closure: .withBarButtonItemParameter(actionClosure))
	}
	
	// MARK: Remove
	/**
	Remove the closure.
	*/
	func removeActionClosure() {
		ActionKitSingleton.sharedInstance.removeBarButtonItemClosure(self)
	}
}
