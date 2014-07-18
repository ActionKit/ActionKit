//
//  ViewController.swift
//  ActionKit
//
//  Created by Kevin Choi on 7/17/14.
//  Copyright (c) 2014 ActionKit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var testButton: UIButton
    
    @IBOutlet var testButton2: UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        testButton.addControlEvent(.TouchUpInside) {
            self.testButton.setTitle("Tapped!", forState: .Normal)
        }

        var tgr = UITapGestureRecognizer() {
            self.view.backgroundColor = UIColor.redColor()
        }
        tgr.addClosure() {
            self.testButton2.setTitle("tapped once on the screen!", forState: .Normal)
        }
        
        var dtgr = UITapGestureRecognizer() {
            self.view.backgroundColor = UIColor.yellowColor()
        }
        
        
        dtgr.numberOfTapsRequired = 2
        view.addGestureRecognizer(dtgr)
        
        testButton.addControlEvent(.TouchUpInside, closure: {
            self.testButton2.setTitle("Tapped2!", forState: .Normal)
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

