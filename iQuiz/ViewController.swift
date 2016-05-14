//
//  ViewController.swift
//  iQuiz
//
//  Created by iGuest on 4/29/16.
//  Copyright © 2016 iGuest. All rights reserved.
//

import UIKit

import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var responseArray : NSArray?
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
//    @objc func tableView(tableView : UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: QuizTableCell = tableView.dequeueReusableCellWithIdentifier("customCell") as! QuizTableCell
        
        let (image, title, detail, topicNumber) = ApplicationData.Instance.categories[indexPath.row]
        
        cell.loadItem(image, passedTitle: title, passedDetail: detail, topicNumber : topicNumber)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let filePath = documents.stringByAppendingString("iQuizData.json")
        
        let jsonData = NSData(contentsOfFile: filePath)
        
        NSLog((jsonData?.description)!)
        
        if jsonData == nil {
            goFetchData()
        } else {
            var jsonArray : NSArray?
            do {
                jsonArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: []) as? NSArray
            } catch {
                goFetchData()
            }
            
            if jsonArray == nil {
                goFetchData()
            } else {
                appDataInstance.populate(jsonArray)
            }
            
        }

        
    }
    
    func goFetchData() {
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


