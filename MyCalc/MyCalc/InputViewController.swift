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
        mainViewController?.buttonPressed(button: sender)
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        mainViewController?.performingCurrentOperation(operation: sender)
    }
    
    @IBAction func clear(_ sender: AnyObject) {
        mainViewController?.clerAll(operand: sender)
    }
}
