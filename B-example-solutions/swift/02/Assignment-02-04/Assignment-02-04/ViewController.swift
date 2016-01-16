//
//  ViewController.swift
//  Assignment-02-04
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
        
        NSLog("%@", business.address)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

