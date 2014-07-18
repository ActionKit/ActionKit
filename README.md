# ActionKit
ActionKit is a light-weight, easy to use framework that wraps the target-action design paradigm into a less verbose, cleaner format. It shortens target-action method calls by removing the target and replacing the selector with a closure.

## Target-action example without ActionKit
`
button.addTarget(self, action: Selector("buttonWasTapped:"), forControlEvents: .TouchUpInside)

...

func buttonWasTapped(sender: UIButton!) {
        self.button.setTitle("Butotn was tapped!", forState: .Normal)
    }
`

## Target-action example with ActionKit
`
button.addControlEvent(.TouchUpInside) {
    self.testButton.setTitle("Button was tapped!", forState: .Normal)
}
`

## Methods
### UIControl
### UIGestureRecognizer

## How it works
ActionKit extends target-action functionality by providing easy to use methods that take closures instead of a selector. ActionKit uses a singleton which stores the closures and acts as the target. Closures capture and store references to any constants and variables from their context, so the user is free to use variables from the context in which the closure was defined in.

## Supported

## In the pipeline
- Adding multiple actions for a single UIGestureRecognizer
- Adding multiple actions for a single UIControl
