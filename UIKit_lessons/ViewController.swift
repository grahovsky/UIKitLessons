//
//  ViewController.swift
//  UIKit_lessons
//
//  Created by Konstantin on 11.09.2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        swipesTapObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func swipesTapObservers() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(pressTap))
        tripleTap.numberOfTapsRequired = 3
        self.view.addGestureRecognizer(tripleTap)
        
        let dobleTap = UITapGestureRecognizer(target: self, action: #selector(pressTap))
        dobleTap.require(toFail: tripleTap) // игнорируем если тройной тап
        dobleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(dobleTap)

    }
    
    @objc func handleSwipes(gester: UISwipeGestureRecognizer) {
        
        switch gester.direction {
        case .right:
            textLabel.text = "Right swipe was recognized"
        case .left:
            textLabel.text = "Left swipe was recognized"
        case .up:
            textLabel.text = "Up swipe was recognized"
        case .down:
            textLabel.text = "Down swipe was recognized"
        default:
            break
        }
        
    }
    
    @objc func pressTap(gester: UITapGestureRecognizer) {
        switch gester.numberOfTapsRequired {
        case 2:
            textLabel.text = "Doble tap was recognized"
        case 3:
            textLabel.text = "Triple tap was recognized"
        default:
            break
        }
    }

}

