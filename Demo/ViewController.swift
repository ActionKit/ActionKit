//
//  ViewController.swift
//  ActionKit
//
//  Created by Kevin Choi, Benjamin Hendricks on 7/17/14.
//  Copyright (c) 2014 ActionKit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Test buttons used for our implementation of target action
    @IBOutlet var testButton: UIButton!
    @IBOutlet var testButton2: UIButton!
    
    // Test buttons used for a regular usage of target action without ActionKit
    @IBOutlet var oldTestButton: UIButton!
    @IBOutlet var oldTestButton2: UIButton!
    
    // Part of making old test button changed to tapped. This is what ActionKit tries to avoid doing
    // by removing the need to explicitly declare selector functions when a closure is all that's needed
    func tappedSelector(sender: UIButton!) {
        self.oldTestButton.setTitle("Old Tapped!", forState: .Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // This is equivalent to oldTestButton's implementation of setting the action to Tapped
        testButton.addControlEvent(.TouchUpInside) {
            self.testButton.setTitle("Tapped!", forState: .Normal)
        }
        
        oldTestButton.addTarget(self, action: Selector("tappedSelector:"), forControlEvents: .TouchUpInside)

        var tgr = UITapGestureRecognizer(name: "setRed") {
            self.view.backgroundColor = UIColor.redColor()
        }
        // The following three lines will replace the action for the red color gesture recognizer to just change the text of the first test button only. Only one action per gesture recognizer (or a control event for that matter)
        // More actions per gesture recognizer and for control events are in the works.
        tgr.addClosure("setButton1") {
            self.testButton.setTitle("tapped once on the screen!", forState: .Normal)
        }
        
        var dtgr = UITapGestureRecognizer(name: "setYellow") {
            self.view.backgroundColor = UIColor.yellowColor()
        }
        
        
        dtgr.numberOfTapsRequired = 2
        // These two gesture recognizers will change the background color of the screen. dtgr will make it yellow on a double tap, tgr makes it red on a single tap. 
//        tgr.removeClosure("setButton1")
        view.addGestureRecognizer(dtgr)
        view.addGestureRecognizer(tgr)
        
        // This adds a closure to the second button on the screen to change the text to Tapped2! when being tapped
        testButton2.addControlEvent(.TouchUpInside, closure: {
            self.testButton2.setTitle("Tapped2!", forState: .Normal)
            })
        
        // This shows that you can remove a control event that has been set. Originally, tapping the first button on the screen
        // would set the text to tapped! (line 31), but this removes that.
        testButton.removeControlEvent(.TouchUpInside);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

