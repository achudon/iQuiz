//
//  QuestionPageController.swift
//  iQuiz
//
//  Created by iGuest on 5/10/16.
//  Copyright © 2016 iGuest. All rights reserved.
//

import UIKit

class QuestionPageController : UIViewController {
    
    var appData = ApplicationData.Instance
    var pickerData : [String] = [String]()
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var currQuiz = appData.quizzes[appData.currentTopic]
//        
//        var currQuestion = currQuiz.questions[currQuiz.currentQuestion]
//        
//        currQuiz.currentQuestion = currQuiz.currentQuestion + 1
        
          pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
}