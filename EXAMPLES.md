![Banner](actionKitBanner.png)

# ActionKit

ActionKit is a light-weight, easy to use framework that wraps the target-action design paradigm into a less verbose, cleaner format. It shortens target-action method calls by removing the target and replacing the selector with a closure.

Back to [main readme](README.md)

## Methods: `UIControl`

### Adding an action closure for a control event

```swift
- addControlEvent(_ controlEvents: UIControlEvents, _ closure: @escaping () -> ())

- addControlEvent(_ controlEvents: UIControlEvents, _ controlClosure: @escaping (UIControl) -> ())
```

### Examples
#### addControlEvent, empty closure
```swift
- addControlEvent(_ controlEvents: UIControlEvents, _ closure: @escaping () -> ())
```

#### usable for `UIButton`
```swift
button.addControlEvent(.touchUpInside) {
  
  self.button.setTitle("Button was tapped!", forState: .Normal)

}
```

#### or any `UIControl`
```swift
switch.addControlEvent(.valueChanged) {
  [weak self]
  self?.demoLabel.text = "Switch value changed!"
}
```

#### Notes
When no closure parameter is given, be aware that any references to the original control are by default a strong reference to that object. However, as shown in the second example by adding the `[weak self]` annotation, this is instead a weak reference and will not risk causing a retain cycle.

For any given control, you can assign an action per controlEvent type. You cannot, however, assign multiple actions to `touchUpInside` -- the same controlEvent type.

#### addControlEvent, `UIControl` closure
```swift
- addControlEvent(_ controlEvents: UIControlEvents, _ controlClosure: @escaping (UIControl) -> ())
```

#### usable for `UIButton`
```swift
button.addControlEvent(.touchUpInside) { (control: UIControl) in
    guard let button = control as? UIButton else {
      return
    }
    button.setTitle("Button was tapped!", forState: .Normal)

}
```

#### or any `UIControl`
```swift
switch.addControlEvent(.valueChanged) { (control: UIControl) in
  [weak self]
  guard let switch = control as? UISwitch,
        let strongSelf = self else {
          return
  }
  strongSelf.demoLabel.text = "Switch value changed!"
  switch.backgroundColor.toggle()
}
```

#### Notes
With a closure parameter, there can still be strong references to the parent class. This example shows how to use a `guard` to unwrap the `weak self`, and otherwise abort the closure. Once unwrapped, further optional chaining is unneeded, a nice syntactic outcome.

### Removing an action closure for a control event

```swift
- removeControlEvent(controlEvents: UIControlEvents)
```

#### Example

```swift
button.removeControlEvent(.touchUpInside)
```

#### Notes 
When a `UIControl` with associated actions is removed from it's superview, all associated actions are removed. This behavior can be overriden, but should be done at your own risk. This behavior currently ensures references to `UIControl`s aren't kept longer than needed (and therefore causing a memory leak through a reference cycle).

## Methods: `UIGestureRecognizer`

### Initializing a gesture recognizer with an action closure

```swift
- init(_ name: String, closure: @escaping () -> ())

- init(_ name: String, gestureClosure: @escaping (UIGestureRecognizer) -> ())
```

### Examples

#### init, empty closure
```swift
- init(_ name: String, closure: @escaping () -> ())
```

#### usable for `UITapGestureRecognizer`
```swift
var singleTapGestureRecognizer = UITapGestureRecognizer() {
  self.view.backgroundColor = UIColor.redColor()
}
```

#### or any other `UIGestureRecognizer` subclass
```swift
var panGestureRecognizer = UIPanGestureRecognizer() {
  [weak self]
  self?.view.backgroundColor = UIColor.redColor()
}
```

#### init, `UIGestureRecognizer` in closure
```swift
- init(_ name: String, gestureClosure: @escaping (UIGestureRecognizer) -> ())
```

#### usable for `UITapGestureRecognizer`
```swift
var singleTapGestureRecognizer = UITapGestureRecognizer() { (gesture: UIGestureRecognizer) in
  if gesture.state == .Began {
      let locInView = gesture.locationInView(self.view)
      ...
  }
}
```

#### or any other `UIGestureRecognizer` subclass
```swift
var panGestureRecognizer = UIPanGestureRecognizer() { (gesture: UIGestureRecognizer) in
  if gesture.state == .Cancelled || gesture.state == .Ended  {
      let locInView = gesture.locationInView(self.view)
      ...
  }
}
```

### Adding an action closure to a gesture recognizer
```swift
- addClosure(name: String, closure: () -> ())

- addClosure(name: String, closureWithGesture: (UIGestureRecognizer) -> ())
```
#### Example
```swift
singleTapGestureRecognizer.addClosure("makeBlue") {
  self.view.backgroundColor = UIColor.blueColor()
}
```

### Removing an action closure for a control event
```swift
- removeClosure(_ name: String)
```
#### Example
```swift
singleTapGestureRecognizer.removeClosure("makeBlue")
```

#### Notes 
When a `UIGestureRecognizer` is no longer needed, any references kept in closures added to the gesture need to be removed. Either by calling `removeClosure` as shown above for each named closure, or by simply calling `clearActionKit()` on the gestureRecognizer which will remove all associated named closures for the recognizer.

## Methods: `UIBarButtonItem`
### Initializing a bar button item with an action closure.

#### without parameters:
```swift
// Init with image
- init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .Plain, actionClosure: () -> Void)

// Init with title
- init(title: String, style: UIBarButtonItemStyle = .Plain, actionClosure: () -> Void)

// Init with barButtonSystemInit
- init(barButtonSystemItem systemItem: UIBarButtonSystemItem, actionClosure: () -> Void) 
```

#### with parameters:
```swift
// Init with image
- init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .Plain, actionWithItem: UIBarButtonItem -> Void)

// Init with title
- init(title: String, style: UIBarButtonItemStyle = .Plain, actionWithItem: UIBarButtonItem -> Void)

// Init with barButtonSystemInit
- init(barButtonSystemItem systemItem: UIBarButtonSystemItem, actionWithItem: UIBarButtonItem -> Void) 
```

#### Examples
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

### Adding an action closure for a bar button item
```
- addActionClosure(actionClosure: () -> ())
```

#### Example
```
titleItem.addActionClosure {
	print("new action")
}
```

### Removing an action closure for a bar button item 
```
- clearActionKit()
```
#### Example
```
titleItem.clearActionKit()
```
