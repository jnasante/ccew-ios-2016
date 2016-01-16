//
//  ViewController.swift
//  Assignment-01-05
//
//  Created by Philip Dow on 8/28/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var webView : UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let text = "http://news.google.com"
        let URL = NSURL(string: text)
        
        if let URL = URL {
            let request = NSURLRequest(URL: URL)
            webView.loadRequest(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}