//
//  ViewController.swift
//  11-networking
//
//  Created by Joseph Asante on 9/22/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        doNetworking()
        print("Hey!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authenticate()
    {
        let userName = "user"
        let password = "pass"
        
        Alamofire.request("https://httpbin.org/basic-auth/\(userName)/\(password)")
            .authenticate(user: userName, password: password)
            .responseJSON { response in
                debugPrint(response)
        }
        
    }

    func doNetworking()
    {
        self.showColorWheel()
        
        let parameters: Parameters = [
            "name": "bawb",
            "foo": "bar",
            "hey": [
                "x": "y"
            ]
        ]
        
        Alamofire.request("https://httpbin.org/post", parameters: parameters)
            .validate()
            .responseJSON { (response) in
//            print(response.request)
//            print(response.response)
//            print(response.result)
            
            switch response.result {
            case .success:
                print("success!")
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    self.letsGo()
                    self.dismissColorWheel()
                }
              case .failure:
                print("you're a failure")
            }
            
        }
        
        // HTTP body: name=bawb&foo=bar&hey=[x]=y
    }
    
    func showColorWheel()
    {
        
    }
    
    func dismissColorWheel()
    {
        
    }
    
    func letsGo()
    {
        // calculation
    }

}

