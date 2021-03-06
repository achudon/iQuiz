//
//  QuizTableCell.swift
//  iQuiz
//
//  Created by iGuest on 4/29/16.
//  Copyright © 2016 iGuest. All rights reserved.
//

import UIKit

class QuizTableCell : UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
   
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var detail: UILabel!
    
    private var topicNumber = -1
    
    func loadItem(iconPath : String, passedTitle : String, passedDetail : String, topicNumber : Int) {
        title.text = passedTitle
        self.detail.text = passedDetail
        icon.image = UIImage(named : iconPath)
        self.topicNumber = topicNumber
    }

}