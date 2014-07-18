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

        testButton.addControlEvent(.TouchUpInside, closure: {
            self.testButton2.setTitle("Tapped2!", forState: .Normal)
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

