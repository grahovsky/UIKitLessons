//
//  ContetViewController.swift
//  UIKit_lessons
//
//  Created by Konstantin on 20.09.2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var presentTextLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var presentText = ""
    var emoji = ""
    var currentPage = 0 // Номер текущей страницы
    var numberOfPages = 0 // Общее количество страниц
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentTextLabel.text = presentText
        emojiLabel.text = emoji
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = numberOfPages

    }

   

}
