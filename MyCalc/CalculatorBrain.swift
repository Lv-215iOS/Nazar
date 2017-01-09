//
//  CalculatorBrain.swift
//  MyCalc
//
//  Created by AdminAccount on 12/7/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import UIKit

class CalculatorBrain: CalcBrainInterface {
    
    var result: ((Double?, Error?)->())? = nil
    var leftOperand: Double?
    var rightOperand: Double?
    var resultValue: Double?
    var userIsTyping = false
           var operationSymbol: BinaryOperation?
    
    func digit(value: Double) {
        if leftOperand == nil {
            leftOperand = value
            print("\(leftOperand)")
   
        } else if rightOperand == nil {
            rightOperand = value
            print("\(rightOperand)")
    
        }
    }
    
    func saveBinaryOperationSymbol(symbol: String){//identifies case from enum as string of the symbol pressed
        switch symbol {
        case "+": operationSymbol = BinaryOperation.Plus
        case "-": operationSymbol = BinaryOperation.Minus
        case "×": operationSymbol = BinaryOperation.Mul
        case "÷": operationSymbol = BinaryOperation.Div
        default: break
        }
    }
    
    func binary(operation: BinaryOperation) {
        switch operation {
        case .Plus:
            resultValue = (leftOperand ?? 0.0) + (rightOperand ?? 0.0)
            result?(resultValue, nil)
        case .Minus:
            resultValue = (leftOperand ?? 0.0) - (rightOperand ?? 0.0)
            result?(resultValue, nil)
        case .Mul:
            resultValue = (leftOperand ?? 0.0) * (rightOperand ?? 0.0)
       result?(resultValue, nil)
        case .Div:
            resultValue = (leftOperand ?? 0.0) / (rightOperand ?? 0.0)
            result?(resultValue, nil)
        default: break
        }
    }
    
    func unary(operation: UnaryOperation) {
        switch operation {
        case .Sqrt:
            leftOperand = (sqrt(leftOperand ?? 0.0 ))
          
        case .Cos:
            leftOperand = (cos(leftOperand ?? 0.0 ))
       
          
        case .Sin:
            leftOperand = (sin(leftOperand ?? 0.0 ))
          
            
        }
    }
    
    func utility(operation: UtilityOperation) {
        switch operation {
        case .Equal:
            if operationSymbol != nil {
                binary(operation: operationSymbol!)
            }
        case .Clean:
            resultValue = 0.0
            leftOperand = nil
            rightOperand = nil
        default:
            break
        }
    }
}
