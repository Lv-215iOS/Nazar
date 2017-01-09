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

    var displayValue: Double {
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
            binaryOperationButtonPressed(operation: operation)
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
            clearPressed(operation : operation)
        case ".":
            dotWasPressed(operation: operation)
        case "=":
            equalWasPressed(operation: operation)
        default:
            buttonPressed(button: operation)
            //calcBrain.digit(value: Double(operation)!)
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
                self.outputController?.outputResult(result: "Not-a-Number")
            } else if(resultValue?.isInfinite)! {
                self.outputController?.outputResult(result: "∞")
            } else {
                self.outputController?.outputResult(result: String(describing: resultValue!))
                print("\(resultValue)")
            }
        }
    }
    
    func buttonPressed(button: String) {
        let digit = button
        if userIsTyping {
            let displayedText = outputController!.display.text!
            outputController!.display.text = displayedText + digit
        } else {
            outputController!.display.text = digit
        }
        userIsTyping = true
    }
    
    func binaryOperationButtonPressed(operation : String) {
        
        if userIsTyping == true && calcBrain.leftOperand == nil {
            calcBrain.digit(value: displayValue)//sets operand
            userIsTyping = false
        } else if userIsTyping == true && calcBrain.leftOperand != nil {//for multiple operations and operations after "="
            calcBrain.digit(value: displayValue)//sets operand
            calcBrain.result = { (resultValue, error)->() in
                self.outputController?.outputInfo(info: String(describing: resultValue!))//displays result
            }
            calcBrain.utility(operation: UtilityOperation.Equal)//connected to func utility in brain - counts
            calcBrain.leftOperand = calcBrain.resultValue
            calcBrain.rightOperand = nil
            calcBrain.resultValue = nil
            userIsTyping = false
        }
    }
    
    func clearPressed(operation : String) {
        calcBrain.leftOperand = 0
        calcBrain.rightOperand = 0
        displayValue = 0
        outputController?.outputInfo(info: "")
        outputController?.outputResult(result: "")
        userIsTyping = false
        calcBrain.resultValue = nil
        
    }
    
    func unaryOperationProcessing(operation: String) {
        calcBrain.result = { (resultValue, error)->() in
            if resultValue != nil {
                if (resultValue?.isNaN)!  {
                    self.outputController?.outputResult(result: "Not-a-Number")
                } else if(resultValue?.isInfinite)! {
                    self.outputController?.outputResult(result: "∞")
                } else {
                    self.outputController?.outputResult(result: String(describing: resultValue!))
                }
            }
        }
    }
    
    func unaryOperationPressed(operation : String) {
        if calcBrain.rightOperand == nil {
            unaryOperationProcessing(operation: operation)
        } else if calcBrain.resultValue != nil && calcBrain.leftOperand != nil {
            unaryOperationProcessing(operation: operation)
            calcBrain.leftOperand = nil
            calcBrain.rightOperand = nil
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputControllerEmbadSeque" {
            inputController = segue.destination as? InputViewController
            inputController?.buttonDidPress = {[unowned self]
                operation in
                self.buttonDidPress(operation: operation)
            }
        } else if segue.identifier == "OutputControllerEmbadSeque" {
            outputController = segue.destination as? OutputViewController
        }
    }
}
