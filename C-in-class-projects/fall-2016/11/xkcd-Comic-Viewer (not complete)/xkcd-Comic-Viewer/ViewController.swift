//
//  ViewController.swift
//  xkcd-Comic-Viewer
//
//  Created by Joseph Asante on 2/18/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let hostURL = "http://xkcd.com/"
    let jsonParameter = "/info.0.json"
    
    var currentComicURL = "http://xkcd.com/info.0.json"
    var comicURL : String!
    
    var currentComicNumber = 0
    var comicNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Action Methods
    @IBAction func goToPreviousComic(_ sender: AnyObject) {
    }
    
    
    @IBAction func goToNextComic(_ sender: AnyObject) {
    }
    
    // MARK: Networking
    func getComic(_ currentComicNumber : Int) {
        
        comicURL = "\(hostURL)\(comicNumber)\(jsonParameter)"
        let url = currentComicNumber == 0 ? currentComicURL : comicURL
        
        if let comicURL = URL(string: url!) {
            // Get data from URL
            getDataFromURL(comicURL, completion: { (data) -> Void in
                
                if let json: NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                    // Where the magic happens
                    
                    // Get the numer of the latest comic
                    if currentComicNumber == 0 {
                        if let latestComicNumber = json["num"] as? Int {
                            self.currentComicNumber = latestComicNumber
                            self.comicNumber = latestComicNumber
                        }
                    }
                    
                    // Set comic title
                    if let title = json["safe_title"] as? String {
                        self.setComicTitle(title)
                    }
                    
                    // Set image
                    if let imageURL = json["img"] as? String {
                        self.downloadImage(URL(string: imageURL)!)
                        
                    }
                }
                
            })
        }
    }
    
    func getDataFromURL(_ url: URL, completion: @escaping ((_ data: Data?) -> Void)) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in completion(data) }) .resume()
    }
    
    // MARK: UI Elements
    func setComicTitle(_ string: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = string
        }
    }
    
    func downloadImage(_ url: URL) {
        getDataFromURL(url) { data in
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
        }
    }
}

