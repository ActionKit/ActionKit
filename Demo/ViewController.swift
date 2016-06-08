//
//  ViewController.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Licensed under the terms of the MIT license
//

import UIKit
import ActionKit

class ViewController: UIViewController {
    
    // Test buttons used for our implementation of adding control events
    @IBOutlet var testButton: UIButton!
    @IBOutlet var testButton2: UIButton!
    @IBOutlet var testButton3: UIButton!
    
    // Test button used for a regular usage of target action without ActionKit
    @IBOutlet var oldTestButton: UIButton!
    
    // Test button used for setting and removing a control event
    @IBOutlet var inactiveButton: UIButton!
    
    // Part of making old test button changed to tapped. This is what ActionKit tries to avoid doing
    // by removing the need to explicitly declare selector functions when a closure is all that's needed
    func tappedSelector(sender: UIButton!) {
        self.oldTestButton.setTitle("Old Tapped!", forState: .Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //: ##Adding UIControl Events
        //:
        //: Old style of setting a target and action for the button
        oldTestButton.addTarget(self, action: #selector(ViewController.tappedSelector(_:)),
                                forControlEvents: .TouchUpInside)

        // This is equivalent to oldTestButton's implementation of setting the action to Tapped
        testButton.addControlEvent(.TouchUpInside) {
            self.testButton.setTitle("Tapped!", forState: .Normal)
        }

        //: This adds a closure to the second button on the screen to change the text to Tapped2! when being tapped
        testButton2.addControlEvent(.TouchUpInside, closure: {
            self.testButton2.setTitle("Tapped2!", forState: .Normal)
        })

        //: This adds a closure, which receives the UIControl as input parameter, to the third button.
        //: It shows how the UIControl can be mapped to the UIButton, in order to have its title changed.
        testButton3.addControlEvent(.TouchUpInside) { (button: UIButton) in
            button.setTitle("Tapped3!", forState: .Normal)
        }

        //: The following shows that you can remove a control event that has been set.
        //: Initially, tapping the first button on the screen would set the text to "Tapped!" ...
        inactiveButton.addControlEvent(.TouchUpInside) {
            self.inactiveButton.setTitle("Tapped!", forState: .Normal)
        }
        
        //: ... but then the following removes that.
        inactiveButton.removeControlEvent(.TouchUpInside);

        
        //: #Adding GestureRecognizers
        //:
        //: Add a Tap Gesture Recognizer (tgr)
        let tgr = UITapGestureRecognizer(name: "setRed") {
            self.view.backgroundColor = UIColor.redColor()
        }
        
        //: The following three lines will add an additional action to the red color gesture recognizer.
        //:  Multiple actions per gesture recognizer (or control events) are possible.
        tgr.addClosure("setButton1") {
            self.testButton.setTitle("Gesture: tapped once!", forState: .Normal)
        }
        
        //: Add a Double Tap Gesture Recognizer (dtgr)
        let dtgr = UITapGestureRecognizer(name: "setYellow") {
            self.view.backgroundColor = UIColor.yellowColor()
        }
        dtgr.numberOfTapsRequired = 2
        
        //: These two gesture recognizers will change the background color of the screen.
        //: dtgr will make it yellow on a double tap,
        //: tgr makes it red on a single tap.
        view.addGestureRecognizer(dtgr)
        view.addGestureRecognizer(tgr)

        //: The following adds a long press gesture recognizer to the background view.
        //: It also shows it is not necessary to keep a reference to the gesture recognizer
        //: when you only need it inside the closure
        view.addGestureRecognizer(UILongPressGestureRecognizer() { (gesture: UILongPressGestureRecognizer) in
            if gesture.state == .Began {
                let locInView = gesture.locationInView(self.view)
                self.testButton2.setTitle("\(locInView)", forState: .Normal)
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

