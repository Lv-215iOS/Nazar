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
    var decimalUsed = true
    
    var displayValue: Double {
        get {
            return Double(outputController!.display.text!)!
        }
        set {
            outputController!.display.text = String(newValue)
            userIsTyping = false
        }
    }
    /// function which recognize the type of pressed button
    func buttonDidPress(operation : String) {
        switch operation {
        case "+":
            binaryOperationButtonPressed(operation: operation)
        case "-":
            binaryOperationButtonPressed(operation: operation)
        case "*":
            binaryOperationButtonPressed(operation: operation)
        case "/":
            binaryOperationButtonPressed(operation: operation)
        case "^":
            binaryOperationButtonPressed(operation: operation)
        case "sqrt":
            unaryOperationPressed(operation: operation)
        case "cos":
            unaryOperationPressed(operation: operation)
        case "sin":
            unaryOperationPressed(operation: operation)
        case "C":
            cleanPressed(operation : operation)
        case ".":
            dotWasPressed(operation: operation)
        case "=":
            equalWasPressed(operation: operation)
            
        default:
            buttonPressed(button: operation)
            
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
            calcBrain.digit(value: displayValue)
            calcBrain.saveBinaryOperationSymbol(symbol: operation)
            userIsTyping = false
        } else if userIsTyping == true && calcBrain.leftOperand != nil {
            calcBrain.digit(value: displayValue)
            calcBrain.result = { (resultValue, error)->() in
                self.outputController?.outputResult(result: NSString(format: "%.14g", resultValue!) as String)// displays result
            }
            calcBrain.utility(operation: UtilityOperation.Equal)
            calcBrain.leftOperand = calcBrain.resultValue
            calcBrain.rightOperand = nil
            calcBrain.resultValue = nil
            userIsTyping = false
            calcBrain.saveBinaryOperationSymbol(symbol: operation)
        } else {
            calcBrain.saveBinaryOperationSymbol(symbol: operation)
        }
        
    }
    
    func unaryOperationPressed(operation : String) {
        if calcBrain.rightOperand == nil {
            equalWasPressed(operation: operation)
            calcBrain.saveUnaryOperationSymbol(symbol: operation)
        } else if calcBrain.resultValue != nil && calcBrain.leftOperand != nil {
            equalWasPressed(operation: operation)
            calcBrain.saveUnaryOperationSymbol(symbol: operation)
            calcBrain.leftOperand = nil
            calcBrain.rightOperand = nil
        }
    }
    
    func equalWasPressed (operation: String) {
        calcBrain.result = { (resultValue, error) ->() in
            if resultValue != nil {
                self.outputController?.outputResult(result: NSString(format: "%.14g", resultValue!) as String)//displays result
            }
        }
        if calcBrain.leftOperand != nil && calcBrain.rightOperand != nil {
            calcBrain.leftOperand = calcBrain.resultValue
        }
        calcBrain.digit(value: displayValue)
        calcBrain.utility(operation: UtilityOperation.Equal)
    }
    
    func dotWasPressed(operation: String) {
        if decimalUsed && userIsTyping {
            outputController!.display.text = String(outputController!.display.text! + ".")
            decimalUsed = false
        } else if !decimalUsed && !userIsTyping {
            outputController!.display.text = String("0.")
            userIsTyping = true
        }
    }
    
    func cleanPressed(operation : String) {
        calcBrain.utility(operation: .Clean)
        displayValue = 0
        outputController?.outputInfo(info: "")
        outputController?.outputResult(result: "0")
        userIsTyping = false
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
