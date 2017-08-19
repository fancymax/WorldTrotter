//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by fancymax on 2017/8/14.
//  Copyright © 2017年 ws. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var celsiusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
    }
    
    var fahrenheitValue:Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue:Measurement<UnitTemperature>? {
        if let value = fahrenheitValue {
            return value.converted(to: .celsius)
        }
        else {
            return nil
        }
    }
    
    var numberFormatter:NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value:value.value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fahrenheitFieldEditingChange(_ sender: UITextField) {
        if let text = sender.text,let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender:AnyObject?) {
        textField.resignFirstResponder()
    }
}

extension ConversionViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let decimalSeperator = Locale.current.decimalSeparator ?? "."
        
        let existTextHasDecimalSeperator = textField.text?.range(of: decimalSeperator)
        let replacementTextHasDecimalSeperator = string.range(of: decimalSeperator)
        
        if existTextHasDecimalSeperator != nil,
            replacementTextHasDecimalSeperator != nil {
            return false
        }
        
        let allowedCharacters = CharacterSet.decimalDigits
        let newStr = string.components(separatedBy: decimalSeperator).joined()
        let charactersSet = CharacterSet(charactersIn: newStr)
        return allowedCharacters.isSuperset(of: charactersSet)
    }
}
