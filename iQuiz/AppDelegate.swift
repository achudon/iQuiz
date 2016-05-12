//
//  AppDelegate.swift
//  iQuiz
//
//  Created by iGuest on 4/29/16.
//  Copyright © 2016 iGuest. All rights reserved.
//

import UIKit

public class ApplicationData {
    
    public var data : NSArray? = []
    
    public var currentTopic = -1
    
    public var topicList : [String] = []
    
    public var topicDescriptions : [String] = []
    
    public var categories : [(String, String, String)] = []
    
    public var quizzes : [Quiz] = []
    
    private static var _instance = ApplicationData()
    
    public static var Instance : ApplicationData {
        get {return _instance }
    }
    
    func populate() {
        for quiz in data! {
            let currTitle = quiz["title"]
            let currDesc = quiz["desc"]
            topicList.append(currTitle!!.description)
            topicDescriptions.append(currDesc!!.description)
            
            setCategories()
        }
    }
    
    func setCategories() {
        let titles = topicList
        let descriptions = topicDescriptions
        
        for i in 0 ..< titles.count {
            categories.append(("done", titles[i], descriptions[i]))
        }
    }
    
    
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func getData(completion: ((data: NSArray?) -> Void)) {
        let url = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var responseArray : NSArray? = []
            do {
                responseArray =  try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray
            } catch {
                responseArray = nil
            }
            completion(data: responseArray)
            
        }
        task.resume()
    }
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let appDataInstance = ApplicationData.Instance
        
        let completionFunction : (NSArray?) -> () =
            {data in
            dispatch_async(dispatch_get_main_queue()) {
                appDataInstance.data = data
                appDataInstance.populate()
            }
        }
        
        func getCategories() {
            let appDataInstance = ApplicationData.Instance
            let descriptions = appDataInstance.topicDescriptions
            print("descriptions")
            print(descriptions)
            
        }
        
        
        // get JSON data
        getData(completionFunction)

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

