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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OutputControllerEmbedSegue" {
            outputController = segue.destination as? OutputViewController
            //outputController?.ViewController = self
        } else if segue.identifier == "InputControllerEmbedSegue" {
            inputController = segue.destination as? InputViewController
            inputController?.mainViewController = self
        }
    }
    
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
        default:
             outputController?.outputInfo(info: operation)
            calcBrain.digit(value: Double(operation)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

