//
//  Quiz.swift
//  iQuiz
//
//  Created by iGuest on 5/7/16.
//  Copyright © 2016 iGuest. All rights reserved.
//

import Foundation


public class Quiz {
    
    public var title : String
    public var desc : String
    public var questions : [Question]
    
    public var currentQuestion = -1
    
    init(title : String, desc : String, questions : [Question]) {
        self.title = title
        self.desc = desc
        self.questions = questions
    }
    
}


public class Question {
    public var text : String
    public var answer : Int
    public var userAnswer : Int
    public var answers : [String]
    
    init(text : String, answer : Int, answers : [String], userAnswer : Int){
        self.text = text
        self.answer = answer
        self.answers = answers
        self.userAnswer = userAnswer
    }
}