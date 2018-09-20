//
//  ViewController.swift
//  UIKit_lessons
//
//  Created by Konstantin on 11.09.2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static var presentationWasViewed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startPresentation()
    }
    
    func startPresentation() {
        
        //let userDefaults = UserDefaults.standard
        //let presetationWasViewed = userDefaults.bool(forKey: "presentationWasViewed")
        
        //if presetationWasViewed == false {
        if !ViewController.presentationWasViewed {
            
            if let pageViewController = storyboard?.instantiateViewController(
                withIdentifier: "PageViewController") as? PageViewController {
                
                
                present(pageViewController, animated: true, completion: nil)
                ViewController.presentationWasViewed = true
            }
        }
    }


}

