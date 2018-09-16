//
//  ViewController.swift
//  UIKit_lessons
//
//  Created by Konstantin on 11.09.2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var uiElements = ["UISegmentedControl",
                      "UILabel",
                      "UISlider",
                      "UITextField",
                      "UIButton",
                      "UIDataPicker"]
    
    var selectedElement: String?
    
    @IBOutlet weak var segmentedContol: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var switchLabel: UILabel!
    
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
        
        choiceUIElement()
        createToolbar()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideAllElements(){
        
        segmentedContol.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        //textField.isHidden = !textField.isHidden
        doneButton.isHidden = true
        datePicker.isHidden = true
        
    }
    
    func choiceUIElement(){
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        
        textField.inputView = elementPicker
        
        //Castomisation
        elementPicker.backgroundColor = .black
        
    }
    
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                        action: #selector(dismissKeyboard))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolbar
        
        //Castomization
        toolbar.tintColor = .white
        toolbar.barTintColor = .black
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        segmentedContol.isHidden = !segmentedContol.isHidden
        label.isHidden = !label.isHidden
        slider.isHidden = !slider.isHidden
        textField.isHidden = !textField.isHidden
        doneButton.isHidden = !doneButton.isHidden
        datePicker.isHidden = !datePicker.isHidden
        
        if sender.isOn {
            switchLabel.text = "отобразить все элементы"
        } else {
            switchLabel.text = "скрыть все элементы"
        }
        
        
    }
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //return 1
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return uiElements.count
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //return uiElements[row]
        return uiElements[component*3+row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //selectedElement = uiElements[row]
        selectedElement = uiElements[component*3+row]
        textField.text = selectedElement
        
        hideAllElements()
        
        switch component*3+row {
        case 0:
            segmentedContol.isHidden = false
        case 1:
            label.isHidden = false
        case 2:
            slider.isHidden = false
        case 3:
            textField.isHidden = false
        case 4:
            doneButton.isHidden = false
        case 5:
            datePicker.isHidden = false
        default:
            print("error")
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerViewLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        
        pickerViewLabel.textColor = .white
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 23)
        //pickerViewLabel.text = uiElements[row]
        pickerViewLabel.text = uiElements[component*3+row]
        
        return pickerViewLabel
        
    }
    
}
