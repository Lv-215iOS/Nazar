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
    var userIsTyping = false
    var decimalUsed = false
    var disolayValue: Double {
        get {
            return Double(outputController!.display.text!)!
        }
        set {
            outputController!.display.text = String(newValue)
        }
    }
    
    
    func buttonDidPress(operation : String) {
        switch operation {
        case "+":
            outputController?.outputInfo(info: operation)
            calcBrain.binary(operation: .Plus)
        case "-":
            outputController?.outputInfo(info: operation)
            calcBrain.binary(operation: .Minus)
        case "*":
            outputController?.outputInfo(info: operation)
            calcBrain.binary(operation: .Mul)
        case "/":
            outputController?.outputInfo(info: operation)
            calcBrain.binary(operation: .Div)
        case "sqrt":
            outputController?.outputInfo(info: operation)
            calcBrain.unary(operation: .Sqrt)
            
        case "cos":
            outputController?.outputInfo(info: operation)
            calcBrain.unary(operation: .Cos)
        case "sin":
            outputController?.outputInfo(info: operation)
            calcBrain.unary(operation: .Sin)
        case "C":
            outputController?.outputInfo(info: operation)
            calcBrain.utility(operation: .Clean)
        case ".":
            dotWasPressed(operation: operation)
        case "=":
            equalWasPressed(operation: operation)
        default:
            outputController?.outputInfo(info: operation)
            calcBrain.digit(value: Double(operation)!)
        }
    }
    
    func dotWasPressed(operation: String) {
        if decimalUsed && userIsTyping {
            outputController!.display.text = String(outputController!.display.text! + ".")
            decimalUsed = true
        } else if !decimalUsed && !userIsTyping {
            outputController!.display.text = String("0.")
            userIsTyping = true
        }
    }
    
    func equalWasPressed (operation: String) {
        calcBrain.result = { (resultValue, error) ->() in
            if (resultValue?.isNaN)!  {
                self.outputController?.outputInfo(info: "Not-a-Number")
            } else if(resultValue?.isInfinite)! {
                self.outputController?.outputInfo(info: "∞")
            } else {
                self.outputController?.outputInfo(info: String(describing: resultValue!))
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputControllerEmbadSeque" {
            inputController = segue.destination as? InputViewController
        } else if segue.identifier == "OutputControllerEmbadSeque" {
            outputController = segue.destination as? OutputViewController
        }
    }
}
