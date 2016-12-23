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
    var UserIsInTheMiddleOfTyping = false
    var decimalUsed = false
    var displayValue: Double {
        get {
            return Double(outputController!.display.text!)!
        }
        set {
            outputController!.display.text = String(newValue)
        }
    }
    
    func buttonPressed(button: UIButton) {
        let digit = button.currentTitle!
        if UserIsInTheMiddleOfTyping {
            if digit == "." && decimalUsed == true {
                decimalUsed = false
            } else if digit == "." && decimalUsed == false {
                decimalUsed = true
            }
            let TextCurrentlyInDisplay = outputController!.display.text!
            outputController!.display.text = TextCurrentlyInDisplay + digit
        } else {
            outputController!.display.text = digit
        }
        UserIsInTheMiddleOfTyping = true
    }
   
    func performingCurrentOperation(operation: UIButton) {
        if UserIsInTheMiddleOfTyping {
            calcBrain.digit(value: displayValue)
            UserIsInTheMiddleOfTyping = false
        }
        calcBrain.perform0peration(symbol: operation.currentTitle!)
        calcBrain.result = { (value, error) -> () in
            if (value != nil) {
                self.outputController?.outputResult(info: "\(value!)")
            }
        }
    }
    
    func clerAll(operand: AnyObject) {
        print("clear pressed")
        calcBrain.clear()
        calcBrain.result = { (value, error) -> () in
            self.displayValue = value!
        }
        self.outputController?.display.text = "0"
        self.outputController?.display2.text = "0"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputControllerEmbadSeque" {
            inputController = segue.destination as? InputViewController
            inputController?.mainViewController = self
        } else if segue.identifier == "OutputControllerEmbadSeque" {
            outputController = segue.destination as? OutputViewController
        }
    }
}
