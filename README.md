<img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" align="right" vspace="2px">

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

## Target-action example with ActionKit

```swift
button.addControlEvent(.TouchUpInside) {
  
  self.button.setTitle("Button was tapped!", forState: .Normal)

}
```

## Target-action example with ActionKit with closure parameter

```swift
button.addControlEvent(.TouchUpInside) { (button: UIButton) in
  
  button.setTitle("Button was tapped!", forState: .Normal)

}
```

## Methods

### UIControl

#### Adding an action closure for a control event

```swift
- addControlEvent(controlEvents: UIControlEvents, closure: () -> ())

- addControlEvent(controlEvents: UIControlEvents, closureWithControl: (UIControl) -> ())
```

##### Examples

```swift
button.addControlEvent(.TouchUpInside) { [weak self] in
  
  self?.button.setTitle("Button was tapped!", forState: .Normal)

}
```

```swift
button.addControlEvent(.TouchUpInside) { (button: UIButton) in
  
    button.setTitle("Button was tapped!", forState: .Normal)

}
```

#### Removing an action closure for a control event

```swift
- removeControlEvent(controlEvents: UIControlEvents)
```

##### Example

```swift
button.removeControlEvent(.TouchUpInside)
```

### UIGestureRecognizer

#### Initializing a gesture recognizer with an action closure

```swift
- init(closure: () -> ())

- init(closureWithGesture: (UIGestureRecognizer) -> ())
```

##### Examples

```swift
var singleTapGestureRecognizer = UITapGestureRecognizer() { [weak self] in
  
  self?.view.backgroundColor = UIColor.redColor()

}
```

```swift
var singleTapGestureRecognizer = UITapGestureRecognizer() { [weak self] (gesture: UITapGestureRecognizer) in
  guard let strongSelf = self else { return }
  if gesture.state == .Began {
      let locInView = gesture.locationInView(strongSelf.view)
      ...
  }

}
```

#### Adding an action closure to a gesture recognizer

```swift
- addClosure(closure: () -> ())

- addClosure(closureWithGesture: (UIGestureRecognizer) -> ())
```

##### Example

```swift
singleTapGestureRecognizer.addClosure("makeBlue") { [weak self] in
  
  self?.view.backgroundColor = UIColor.blueColor()

}
```

#### Removing an action closure for a control event

```swift
- removeActionClosure()
```
##### Example

```swift
singleTapGestureRecognizer.removeActionClosure()
```

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
- removeActionClosure()
```
##### Example
```
titleItem.removeActionClosure()
```

## How it works

ActionKit extends target-action functionality by providing easy to use methods that take closures instead of a selector. ActionKit uses associative references which stores the closures in the object (e.g UIControl) itself reducing risks for memory leaks. Closures capture and store references to any constants and variables from their context, so the user is free to use variables from the context in which the closure was defined in. In general though, be sure to caputure `self` as weak within the closure assigned to controls to prevent retain cycles / memory leaks. Example:

```
button.addControlEvent(.TouchUpInside) { [weak self] in
  self?.button.setTitle("Button was tapped!", forState: .Normal)
}
```

## Migration from previous versions

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

## In the pipeline

- Adding and removing multiple actions for a single UIGestureRecognizer
- Adding and removing multiple actions for a single UIControl
- Better manage stored closures

## Installation

### CocoaPods
 ActionKit is available through [CocoaPods](http://cocoapods.org). To install
 it, simply add the following line to your Podfile:
 
    pod 'ActionKit', '~> 1.1.0'

### Carthage

- 1. Add the following to your *Cartfile*:

```
    github "ActionKit/ActionKit" == 1.1.0
``` 
   
- 2. Run `carthage update`
- 3. Add the framework as described in [Carthage Readme](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)
