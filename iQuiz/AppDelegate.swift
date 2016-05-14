//
//  AppDelegate.swift
//  iQuiz
//
//  Created by iGuest on 4/29/16.
//  Copyright © 2016 iGuest. All rights reserved.
//

import UIKit

import Foundation

public class ApplicationData {
    
    public var data : NSArray? = []
    
    public var currentTopic = -1
    
    public var topicList : [String] = []
    
    public var topicDescriptions : [String] = []
    
    public var categories : [(String, String, String, Int)] = []
    
    public var quizzes : [Quiz] = []
    
    private static var _instance = ApplicationData()
    
    public static var Instance : ApplicationData {
        get {return _instance }
    }
    
    func getData() {
        let url = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")
        var responseArray : NSArray? = []
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            
            do {
                responseArray =  try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray
            } catch {
                responseArray = nil
            }
            
            // save to documents
            let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            let filePath = documents.stringByAppendingString("iQuizData.json")
            
            if responseArray != nil {
                responseArray!.writeToFile(filePath, atomically: true)
            }
            self.populate(responseArray)
        }
        
        task.resume()
    }
    
    func populate(data : NSArray?) {
        
        let responseArray = data
        
        for quiz in responseArray! {
            let currTitle = quiz["title"]
            let currDesc = quiz["desc"]
            self.topicList.append(currTitle!!.description)
            self.topicDescriptions.append(currDesc!!.description)
            
            //                    var questions = quiz["questions"]
            //
            //                    for var i = 0; i < questions!!.count; i += 1 {
            //                        var question : [String] = questions!![i]
            //                        var myQuestion : Question = Question(text: question["text"], answer: question["answer"], answers: question["answers"])
            //                    }
        }
        self.setCategories()
    }
    
    func setCategories() {
        let titles = topicList
        let descriptions = topicDescriptions
        
        for i in 0 ..< titles.count {
            categories.append(("done", titles[i], descriptions[i], i))
        }
    }
    
    
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

