//
//  ViewController.swift
//  UIKit_lessons
//
//  Created by Konstantin on 11.09.2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var actitvityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        //textView.text = nil
        textView.isHidden = true
        textView.alpha = 0
        
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        textView.backgroundColor = self.view.backgroundColor
        textView.layer.cornerRadius = 10
        
        stepper.value = 17
        stepper.minimumValue = 10
        stepper.maximumValue = 25
        stepper.tintColor = .white
        stepper.backgroundColor = .gray
        stepper.layer.cornerRadius = 5
        
        actitvityIndicator.hidesWhenStopped = true
        actitvityIndicator.color = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        actitvityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // Отслеживаем появление клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // Отслеживаем скрытие клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        UIView.animate(withDuration: 0, delay: 5, options: .curveEaseIn, animations: {
            self.textView.alpha = 1
        }) { (finished) in
            self.actitvityIndicator.stopAnimating()
            self.textView.isHidden = false
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }

    // Скрытие клавиатуры по тапу за пределами Text View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true) // Скрывает клавиатуру, вызванную для любого объекта
    
        //textView.resignFirstResponder() // Скрывает клавиатуру, вызванную для конкретного объекта
    }
    
    @objc func updateTextView(notification: Notification){
        
        guard let userInfo = notification.userInfo as? [String: AnyObject],
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height - bottomConstraint.constant, right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        
        textView.scrollRangeToVisible(textView.selectedRange)
        
    }

    @IBAction func sizeFont(_ sender: UIStepper) {
        let fontName = textView.font?.fontName
        let fontSize = CGFloat(sender.value)
        
        textView.font = UIFont(name: fontName!, size: fontSize)
        
    }
    
}

extension ViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) { // Срабатывает при тапе на Text View
        textView.backgroundColor = .white
        textView.textColor = .gray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) { // Срабатывает по окончании работы с Text View
        textView.backgroundColor = self.view.backgroundColor
        textView.textColor = .black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        countLabel.text = "\(textView.text.count)"
        //return textView.text.count + (text.count - range.length) <= 60 // Ограничение длины
        return true
    }
    
}
