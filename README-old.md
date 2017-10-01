![Banner](actionKitBanner.png)
[![Version](https://img.shields.io/cocoapods/v/ActionKit.svg?style=flat)](http://cocoadocs.org/docsets/ActionKit)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/ActionKit.svg?style=flat)](http://cocoadocs.org/docsets/ActionKit)
[![Platform](https://img.shields.io/cocoapods/p/ActionKit.svg?style=flat)](http://cocoadocs.org/docsets/ActionKit)

# ActionKit

This README page is dedicated to old README content that has been retired.
Peruse for your own enjoyment, and to determine if a change has broken anything for you!
Apologies if it did.

## Previous Swift Version Examples

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
