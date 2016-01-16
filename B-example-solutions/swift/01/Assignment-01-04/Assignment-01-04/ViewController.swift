//
//  ViewController.swift
//  Assignment-01-04
//
//  Created by Philip Dow on 8/28/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // You could set this property in interface builder
        imageView.contentMode = .ScaleAspectFill
        
        // Look in Images.xcassets for the bokeh image
        imageView.image = UIImage(named: "bokeh")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

