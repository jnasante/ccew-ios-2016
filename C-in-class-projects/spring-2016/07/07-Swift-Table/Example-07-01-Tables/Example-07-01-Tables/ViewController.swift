//
//  ViewController.swift
//  Example-07-01-Tables
//
//  Created by Philip Dow on 9/12/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // The model will change so we should make it a var instead of a let
    // Create an array literal but specifying its type [Bool] followed
    // by parenthesis and an arrayLiteral parameter
    
    var model = [Bool](arrayLiteral:
        true, false, false, true, true, false, false, true, false, true,
        false, false, false, true, true, false, true, true, false, true,
        true, false, false, false, true, false, false, true, false, false,
        true, false, false, true, true, true, false, true, false, true
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Table View Data Source

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        // For the cell accessory type, normally we would fully specify the constant as
        // UITableViewCellAccessoryType.Checkmark but type inference allows us to specify
        // only the subtype
        
        cell.textLabel!.text = String(format: "Table View Cell: %ld", arguments: [indexPath.row])
        cell.accessoryType = model[indexPath.row] ? .Checkmark : .None
        
        return cell
    }
    
}

// MARK: - Table View Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let selected = !model[indexPath.row]
            
            mutableArrayValueForKey("model").replaceObjectAtIndex(indexPath.row, withObject: selected)
            cell.accessoryType = selected ? .Checkmark : .None
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
}

