//
//  ViewController.swift
//  UIKit_lessons
//
//  Created by Konstantin on 11.09.2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webWiew: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        webWiew.navigationDelegate = self
        
        let homePage = "https://www.apple.com"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        
        urlTextField.text = homePage
        
        webWiew.load(request)
        webWiew.allowsBackForwardNavigationGestures = true
        
        // для http нужно зайти в info.plist и добавить "App Transport Security Settings" -> "Allow Arbitrary Loads" -> "YES"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonAction(_ sender: Any) {
        
        if webWiew.canGoBack {
            webWiew.goBack()
        }
        
    }
    
    @IBAction func forwardButtonAction(_ sender: Any) {
        
        if webWiew.canGoForward {
            webWiew.goForward()
        }
        
    }
    
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        webWiew.load(request)
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        urlTextField.text = webView.url?.absoluteString
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        
    }
}
