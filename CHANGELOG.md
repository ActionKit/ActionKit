## Changelog

### 2.1 -- Released October 1st, 2017

Thank you @brandons for the Swift 4 PR! 
Version 2.1 is simply our update to Swift 4.
Will also have a Swift 3.2 branch for those not yet on Swift 4.

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

