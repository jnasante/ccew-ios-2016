//
//  ViewController.swift
//  Assignment-02-03
//
//  Created by Philip Dow on 9/1/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var business = Business()
        
        business.name = "Phil's Emporium"
        business.type = "Misc."
        business.phone = "555-1234"
        
        business.street = "415 Main Street"
        business.city = "Norman"
        business.state = "OK"
        business.zipcode = "73001"
        
        // The exclamation mark after the getter tells the compiler to automatically
        // "unwrap" the optional and ignore that it may be nil
        
        // This is normally a dangerous operation. We should check for nil with an if let
        // statement, but we've set these values ourselves so we know they are not nil
    
        NSLog("%@", business.name!)
        NSLog("%@", business.type!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

