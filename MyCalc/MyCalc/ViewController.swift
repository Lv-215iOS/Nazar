//
//  ViewController.swift
//  MyCalc
//
//  Created by AdminAccount on 12/7/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var display: UILabel!

    private var userIsTyping = false // check if user is typing

    @IBAction private func pressDigit(_ sender: UIButton) {
        let digit =  sender.currentTitle!
        if userIsTyping{
            let textCurrentlyDisplay = display.text!
            display.text = textCurrentlyDisplay + digit
        }else{
            display.text = digit
        }
        userIsTyping = true
        
            }
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }set{
            display.text = String(newValue)
        }
    }

    private var brain: CalculatorBrain = CalculatorBrain()

    @IBAction  private func performOperation(_ sender: UIButton) {
        if userIsTyping{
            brain.setOperand(operand: displayValue)
            userIsTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
        brain.performOperation(symbol: mathematicalSymbol)
        
        }
        displayValue = brain.result
    }
}

