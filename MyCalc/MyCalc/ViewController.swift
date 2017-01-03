//
//  ViewController.swift
//  MyCalc
//
//  Created by AdminAccount on 12/7/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var outputController : OutputViewController? = nil
    var inputController : InputViewController? = nil
    var calcBrain = CalculatorBrain()
    var userIsInTheMiddleOfTyping = false
    var decimalUsed = false
    var displayValue: Double {
        get {
            return Double(outputController!.display.text!)!
        }
        set {
            outputController!.display.text = String(newValue)
        }
    }
    
    func buttonPressed(button: String) {
        let digit = button
        if userIsInTheMiddleOfTyping {
            let TextCurrentlyInDisplay = outputController!.display.text!
            outputController!.display.text = TextCurrentlyInDisplay + digit
        } else {
            outputController!.display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    func performingCurrentOperation(operation: String) {
        if userIsInTheMiddleOfTyping {
            calcBrain.digit(value: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        decimalUsed = false
        calcBrain.performOperation(symbol: operation)
        
        calcBrain.result = { (value, error) -> () in
            if (value != nil) {
                self.outputController?.outputResult(info: "\(value!)")
            }
        }
    }
    
    func clerButtonPressed(operation: String) {
        userIsInTheMiddleOfTyping = false
        decimalUsed = false
        calcBrain.clear()
        
        calcBrain.result = { (value, error) -> () in
            self.displayValue = value!
        }
        self.outputController?.display.text = "0"
    }
    
    func dotButtonPressed(operation: String) {
        if !decimalUsed && userIsInTheMiddleOfTyping {
            outputController!.display.text = String(outputController!.display.text! + ".")
            decimalUsed = true
        } else if !decimalUsed && !userIsInTheMiddleOfTyping {
            outputController!.display.text = String("0.")
            decimalUsed = true
            userIsInTheMiddleOfTyping = true
        }
    }
    
    func buttonDidPress(operation: String) {
        switch operation {
        case "1": buttonPressed(button: operation)
        case "2": buttonPressed(button: operation)
        case "3": buttonPressed(button: operation)
        case "4": buttonPressed(button: operation)
        case "5": buttonPressed(button: operation)
        case "6": buttonPressed(button: operation)
        case "7": buttonPressed(button: operation)
        case "8": buttonPressed(button: operation)
        case "9": buttonPressed(button: operation)
        case "0": buttonPressed(button: operation)
            
        case ".": dotButtonPressed(operation: operation)
            
        case "+": performingCurrentOperation(operation: operation)
        case "-": performingCurrentOperation(operation: operation)
        case "/": performingCurrentOperation(operation: operation)
        case "*": performingCurrentOperation(operation: operation)
            
        case "√": performingCurrentOperation(operation: operation)
        case "^": performingCurrentOperation(operation: operation)
        case "cos": performingCurrentOperation(operation: operation)
        case "sin": performingCurrentOperation(operation: operation)
        case "%": performingCurrentOperation(operation: operation)
        case "±": performingCurrentOperation(operation: operation)
        case "=": performingCurrentOperation(operation: operation)
            
        case "c": clerButtonPressed(operation: operation)
            
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OutputControllerEmbedSegue" {
            outputController = segue.destination as? OutputViewController
        } else if segue.identifier == "InputControllerEmbedSegue" {
            inputController = segue.destination as? InputViewController
            inputController?.buttonDidPress = { [unowned self] operation in
                self.buttonDidPress(operation: operation)
            }
        }
    }
}
