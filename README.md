[![Version](https://img.shields.io/cocoapods/v/ActionKit.svg?style=flat)](http://cocoadocs.org/docsets/ActionKit)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/ActionKit.svg?style=flat)](http://cocoadocs.org/docsets/ActionKit)
[![Platform](https://img.shields.io/cocoapods/p/ActionKit.svg?style=flat)](http://cocoadocs.org/docsets/ActionKit)
![Swift](https://img.shields.io/badge/%20in-swift%203.0-orange.svg)

# ActionKit

ActionKit is a experimental, light-weight, easy to use framework that wraps the target-action design paradigm into a less verbose, cleaner format. It shortens target-action method calls by removing the target and replacing the selector with a closure.

Licensed under the terms of the MIT license

## Target-action example without ActionKit (prior to Swift 2.2)
```swift
button.addTarget(self, action: Selector("buttonWasTapped:"), forControlEvents: .TouchUpInside)
```

```swift
func buttonWasTapped(sender: UIButton!) {

    self.button.setTitle("Button was tapped!", forState: .Normal)
    
}
```

## Target-action example without ActionKit with Swift 2.2
```swift
button.addTarget(self, action: #selector(ViewController.buttonWasTapped(_:)), forControlEvents: .TouchUpInside)
```

```swift
func buttonWasTapped(sender: UIButton!) {

    self.button.setTitle("Button was tapped!", forState: .Normal)
    
}
```

## Target-action example with ActionKit (swift 3.0+)

```swift
button.addControlEvent(.touchUpInside) {
  
  self.button.setTitle("Button was tapped!", forState: .Normal)

}
```

## Target-action example with ActionKit with closure parameter

```swift
button.addControlEvent(.touchUpInside) { (control: UIControl) in
  guard let button = control as? UIButton else {
    return
  }
  button.setTitle("Button was tapped!", forState: .Normal)

}
```

## Methods

### UIControl

#### Adding an action closure for a control event

```swift
- addControlEvent(_ controlEvents: UIControlEvents, _ closure: @escaping () -> ())

- addControlEvent(_ controlEvents: UIControlEvents, _ controlClosure: @escaping (UIControl) -> ())
```

##### Examples

```swift
button.addControlEvent(.touchUpInside) {
  
  self.button.setTitle("Button was tapped!", forState: .Normal)

}
```

```swift
button.addControlEvent(.touchUpInside) { (control: UIControl) in
    guard let button = control as? UIButton else {
      return
    }
    button.setTitle("Button was tapped!", forState: .Normal)

}
```

#### Removing an action closure for a control event

```swift
- removeControlEvent(controlEvents: UIControlEvents)
```

##### Example

```swift
button.removeControlEvent(.touchUpInside)
```

##### Note: when a UIControl with associated actions is removed from it's superview, all associated actions are removed. This behavior can be overriden, but should be done at your own risk since this ensures references to those UIControls aren't kept longer than needed (and therefore causing a memory leak).

### UIGestureRecognizer

#### Initializing a gesture recognizer with an action closure

```swift
- init(_ name: String, closure: @escaping () -> ())

- init(_ name: String, gestureClosure: @escaping (UIGestureRecognizer) -> ())
```

##### Examples

```swift
var singleTapGestureRecognizer = UITapGestureRecognizer() {
  
  self.view.backgroundColor = UIColor.redColor()

}
```

```swift
var singleTapGestureRecognizer = UITapGestureRecognizer() { (gesture: UIGestureRecognizer) in
  
  if gesture.state == .Began {
      let locInView = gesture.locationInView(self.view)
      ...
  }

}
```

#### Adding an action closure to a gesture recognizer

```swift
- addClosure(name: String, closure: () -> ())

- addClosure(name: String, closureWithGesture: (UIGestureRecognizer) -> ())
```

##### Example

```swift
singleTapGestureRecognizer.addClosure("makeBlue") {
  
  self.view.backgroundColor = UIColor.blueColor()

}
```

#### Removing an action closure for a control event

```swift
- removeClosure(_ name: String)
```
##### Example

```swift
singleTapGestureRecognizer.removeClosure("makeBlue")
```

##### Note: when a UIGestureRecognizer is no longer needed, any references kept in closures added to the gesture need to be removed. Either by calling `removeClosure` as shown above for each named closure, or by simply calling `clearActionKit()` on the gestureRecognizer which will remove all associated named closures for the recognizer.

### UIBarButtonItem
#### Initializing a bar button item with an action closure.

##### Closure without parameters
```swift
// Init with image
- init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .Plain, actionClosure: () -> Void)

// Init with title
- init(title: String, style: UIBarButtonItemStyle = .Plain, actionClosure: () -> Void)

// Init with barButtonSystemInit
- init(barButtonSystemItem systemItem: UIBarButtonSystemItem, actionClosure: () -> Void) 
```

##### Closure with parameters
```swift
// Init with image
- init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .Plain, actionWithItem: UIBarButtonItem -> Void)

// Init with title
- init(title: String, style: UIBarButtonItemStyle = .Plain, actionWithItem: UIBarButtonItem -> Void)

// Init with barButtonSystemInit
- init(barButtonSystemItem systemItem: UIBarButtonSystemItem, actionWithItem: UIBarButtonItem -> Void) 
```

##### Examples
```swift
let titleItem = UIBarButtonItem(title: "Press me") { 
	print("Title item pressed")
}
		
let image = UIImage(named: "alert")!
let imageItem = UIBarButtonItem(image: image) { (item: UIBarButtonItem) in
	print("Item \(item) pressed")
}
		
let systemItem = UIBarButtonItem(barButtonSystemItem: .Action) { 
	print("System item pressed")
}
```

#### Adding an action closure for a bar button item
```
- addActionClosure(actionClosure: () -> ())
```
##### Example
```
titleItem.addActionClosure {
	print("new action")
}
```
#### Removing an action closure for a bar button item 
```
- clearActionKit()
```
##### Example
```
titleItem.clearActionKit()
```

## How it works

ActionKit extends target-action functionality by providing easy to use methods that take closures instead of a selector. ActionKit uses a singleton which stores the closures and acts as the target. Closures capture and store references to any constants and variables from their context, so the user is free to use variables from the context in which the closure was defined in.

## Migration from previous versions

### Version 2.0

Version 2.0 is a full rewrite of the library. As much as possible, backwards compability was kept in mind, and with that said, only a couple things will break:
- inferred parameter types are more generic, now, and will need to be cast to specific control type within closure (think UIGestureRecognizer to UITapGestureRecognizer, for example)
- unnecessary parameter names can now be ommitted, and the compiler will likely warn users about this when updating to version 2.
- memory leaks should now be fixed! Through a couple automatic use cases plus exposing a more clear pattern for clearing references, ActionKit should now be memory leak proof while being fully written for Swift -- no Objective-C associated references!

What's planned:
- automated build tooling, including adding unit tests to ensure stability of ActionKit
- bugs -- with a full rewrite, things will likely break...bug reports and issues will be gladly accepted and fixed ASAP. Additionally, PRs for open issues and bug reports are also welcome, but I will also put in more effort into fixing any issues opened.

### Version 1.1.0

Version 1.1.0 adds an *optional* `UIControl` or `UIGestureRecognizer` to the closure. This might lead to possible backwards-incompatibility.

We made sure you can still call the closures without any parameters, like the following:

```swift
button.addControlEvent(.TouchUpInside) {
    print("the button was tapped")
}
```

However, with previous versions of ActionKit, due to the peculiarity of Swift, it was also possible to call the closure with an unused parameter:

```swift
button.addControlEvent(.TouchUpInside) { _ in
    print("the button was tapped")
}
```

In this example the `_` refers to the empty input tuple `()`.  

Now, with these extra closure parameters, the above is no longer valid, as it is **ambiguous** which method is being called: `addControlEvent` *without* closure parameters *or with* a `UIControl` as closure parameter. When you have this Xcode will report: **Ambiguous use of 'addControlEvent'**.

If you're using `_ in` in your code and you get this ambiguous error, migrate by *either* removing the `_ in` all together *or* by replacing it with `(control: UIControl) in`. (For gesture recognizers use `(gesture: UIGestureRecognizer) in`.)

## Supported

- Adding and removing an action to concrete gesture-recognizer objects, eg. UITapGestureRecognizer, UISwipeGestureRecognizer
- Adding and removing an action for UIControl objects, eg. UIButton, UIView

## Installation

### CocoaPods
 ActionKit is available through [CocoaPods](http://cocoapods.org). To install
 it, simply add the following line to your Podfile:
 
    pod 'ActionKit', '~> 2.0'

### Carthage

- 1. Add the following to your *Cartfile*:

```
    github "ActionKit/ActionKit" == 2.0
``` 
   
- 2. Run `carthage update`
- 3. Add the framework as described in [Carthage Readme](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)
