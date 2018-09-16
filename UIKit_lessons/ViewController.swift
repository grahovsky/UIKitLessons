//
//  ViewController.swift
//  UIKit_lessons
//
//  Created by Konstantin on 11.09.2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedContol: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 90;
        sliderAction(slider)
        
        label.text = String(slider.value)
        //label.isHidden = true
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        //segmentedContol.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .black
        slider.thumbTintColor = .black
        
        datePicker.locale = Locale(identifier: "ru_RU")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func choiceSegment(_ sender: Any) {
        
        label.isHidden = false
        
        switch segmentedContol.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected"
            label.textColor = .red
        case 1:
            label.text = "The second segment is selected"
            label.textColor = .green
        case 2:
            label.text = "The third segment is selected"
            label.textColor = .yellow
        default:
            print("Sothing wrong")
        }
        
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(sender.value)
        
        let backgroundColor = self.view.backgroundColor
        self.view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(sender.value/100))
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        
        guard !textField.text!.isEmpty else { return }
        
        var check = true
        
        let testText = String(textField.text!)
        let regExp = try? NSRegularExpression(pattern: "\\d")
        let matches = regExp?.matches(in: testText, range: NSRange(testText.startIndex..., in: testText))
        for _ in matches!{
            check = false
        }
        
        if !check {
            let alert = UIAlertController(title: "Wrong format", message: "Please enter your name", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.textField.text = nil})
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        } else {
            label.text = textField.text
            textField.text = nil
        }
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker){
        
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .full
        dateFormater.locale = Locale(identifier: "ru_RU")
        
        label.text = dateFormater.string(from: sender.date)
    }
    
}

