//
//  OutPut.swift
//  MyCalc
//
//  Created by AdminAccount on 12/12/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    
    var mainViewController : ViewController? = nil
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        mainViewController?.pressedButton(operation: sender.currentTitle!)
        print("\(sender.currentTitle)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()// Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()// Dispose of any resources that can be recreated.
    }
}
/*
 @IBAction private func pressDigit(_ sender: UIButton) {
 let digit =  sender.currentTitle!
 if userIsTyping{
 let textCurrentlyInDisplay = self.outputController?.display.text!
 self.outputController?.display.text = textCurrentlyInDisplay! + digit
 }else{
 self.outputController?.display.text = digit
 }
 userIsTyping = true
 
 }
 
 var brain: CalculatorBrain = CalculatorBrain()
 
 var displayValue: Double{
 get {
 return Double(display.text!)!
 }set {
 display.text = String(newValue)
 }
 }
 @IBAction   func performOperation(_ sender: UIButton) {
 if userIsTyping{
 brain.setOperand(operand: displayValue)
 userIsTyping = false
 }
 if let mathematicalSymbol = sender.currentTitle{
 brain.performOperation(symbol: mathematicalSymbol)
 
 }
 displayValue = brain.result
 }
 
 
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 if segue.identifier == "InputControllerEmbedSegue" {
 mainViewController = segue.source as? ViewController
 }
 }*/


