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
    
    @IBOutlet weak var tableView: UITableView!
    
    // data for the meantime (while not from database)
    
    var appDataInstance = ApplicationData.Instance
    
    @IBAction func selectSettings(sender: UIBarButtonItem) {
        let settingsController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        settingsController.addAction(defaultAction)
        
        presentViewController(settingsController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApplicationData.Instance.categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: QuizTableCell = tableView.dequeueReusableCellWithIdentifier("customCell") as! QuizTableCell
        
        let (image, title, detail) = ApplicationData.Instance.categories[indexPath.row]
        
        cell.loadItem(image, passedTitle: title, passedDetail: detail)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            ApplicationData.Instance.getData()
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


