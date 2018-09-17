//
//  DetailVC.swift
//  UIKit_lessons
//
//  Created by Konstantin on 17.09.2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var trackTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.image = UIImage(named: trackTitle)
        titleLabel.text = trackTitle
        titleLabel.numberOfLines = 0
        
    }

}
