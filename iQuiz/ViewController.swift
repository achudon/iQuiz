//
//  ViewController.swift
//  iQuiz
//
//  Created by iGuest on 4/29/16.
//  Copyright © 2016 iGuest. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var responseArray : NSArray?
    
    // data for the meantime (while not from database)
    
    var appDataInstance = ApplicationData.Instance
    
    var categories : [(String, String, String)] = []
    
    @IBAction func selectSettings(sender: UIBarButtonItem) {
        let settingsController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        settingsController.addAction(defaultAction)
        
        presentViewController(settingsController, animated: true, completion: nil)
    }
    
    // define how many rows the table should have
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories = appDataInstance.categories
        return categories.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: QuizTableCell = tableView.dequeueReusableCellWithIdentifier("customCell") as! QuizTableCell
        
        categories = appDataInstance.categories
        
        print(categories)
        
        let (image, title, detail) = categories[indexPath.row]
        
        cell.loadItem(image, passedTitle: title, passedDetail: detail)
        
        return cell
    }
    
    func viewWillAppear() {
        categories = appDataInstance.categories
        print(categories)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


