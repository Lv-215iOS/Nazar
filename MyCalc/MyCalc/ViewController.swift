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
    var userIsTyping = true
    
    func pressedButton(operation : String) {
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
        case "=":
            outputController?.outputInfo(info: operation)
            calcBrain.utility(operation: .Equal)
        case "cos":
            outputController?.outputInfo(info: operation)
            calcBrain.unary(operation: .Cos)
        case "sin":
            outputController?.outputInfo(info: operation)
            calcBrain.unary(operation: .Sin)
        case "AC":
            outputController?.outputInfo(info: operation)
            calcBrain.utility(operation: .AClean)
        default:
            outputController?.outputInfo(info: operation)
            calcBrain.digit(value: Double(operation)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


