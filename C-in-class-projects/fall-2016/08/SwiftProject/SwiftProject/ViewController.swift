//
//  ViewController.swift
//  SwiftProject
//
//  Created by Joseph Asante on 9/13/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(String(funkyFunc("funky").int))
        var int:Int
        var str:String
        (str, int) = funkyFunc("funky")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func funkyFunc(_ str:String) -> (str: String, int:Int) {
        return (str, 5)
    }

    
}

