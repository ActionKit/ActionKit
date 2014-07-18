# ActionKit
ActionKit is a experimental, light-weight, easy to use framework that wraps the target-action design paradigm into a less verbose, cleaner format. It shortens target-action method calls by removing the target and replacing the selector with a closure.

## Target-action example without ActionKit
```swift
button.addTarget(self, action: Selector("buttonWasTapped:"), forControlEvents: .TouchUpInside)
```


```swift
func buttonWasTapped(sender: UIButton!) {

    self.button.setTitle("Button was tapped!", forState: .Normal)
    
}
```

## Target-action example with ActionKit
```swift
button.addControlEvent(.TouchUpInside) { self.button.setTitle("Button was tapped!", forState: .Normal) }
```

## Methods
### UIControl
#### Adding an action closure for a control event
```swift
- addControlEvent(controlEvents: UIControlEvents, closure: () -> ())
```
##### Example
```swift
button.addControlEvent(.TouchUpInside) { self.button.setTitle("Button was tapped!", forState: .Normal) }
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
- init(actionClosure: () -> ())
```
##### Example
```swift
var singleTapGestureRecognizer = UITapGestureRecognizer() { self.view.backgroundColor = UIColor.redColor() }
```
#### Adding an action closure to a gesture recognizer
```swift
- addActionClosure(actionClosure: () -> ())
```
##### Example
```swift
singleTapGestureRecognizer.addActionClosure() { self.view.backgroundColor = UIColor.blueColor() }
```
#### Removing an action closure for a control event
```swift
- removeActionClosure()
```
##### Example
```swift
singleTapGestureRecognizer.removeActionClosure()
```

## How it works
ActionKit extends target-action functionality by providing easy to use methods that take closures instead of a selector. ActionKit uses a singleton which stores the closures and acts as the target. Closures capture and store references to any constants and variables from their context, so the user is free to use variables from the context in which the closure was defined in.

## Supported
- Adding and removing an action to concrete gesture-recognizer objects, eg. UITapGestureRecognizer, UISwipeGestureRecognizer
- Adding and removing an action for UIControl objects, eg. UIButton, UIView

## In the pipeline
- Adding and removing multiple actions for a single UIGestureRecognizer
- Adding and removing multiple actions for a single UIControl
- Better manage stored closures
