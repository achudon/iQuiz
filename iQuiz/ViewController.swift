//
//  ViewController.swift
//  iQuiz
//
//  Created by iGuest on 4/29/16.
//  Copyright © 2016 iGuest. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var responseDict : NSDictionary?
    
    func getData() {
        
        let url = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            
            if (data != nil) {
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            } else {
                print("No data")
                
                do {
                    self.responseDict =  try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                } catch {
                    self.responseDict = nil
                }  
            }
        }
        task.resume()
    }
    
    // data for the meantime (while not from database)
    var categories : [(String, String, String)] = [
        ("done", "Mathematics", "All about math!"),
        ("done", "Marvel Super Hereos", "How well do you know the universe?"),
        ("done", "Science", "Lots of science.")
    ]
    
    @IBAction func selectSettings(sender: UIBarButtonItem) {
        let settingsController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        settingsController.addAction(defaultAction)
        
        presentViewController(settingsController, animated: true, completion: nil)
    }
    
    // define how many rows the table should have
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: QuizTableCell = tableView.dequeueReusableCellWithIdentifier("customCell") as! QuizTableCell
        
        let (image, title, detail) = categories[indexPath.row]
        
        cell.loadItem(image, passedTitle: title, passedDetail: detail)
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


