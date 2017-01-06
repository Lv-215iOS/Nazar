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
    var temp: String? = nil
    var userIsTyping = false
    
    func digit(value: Double) {
        if leftOperand == nil {
            leftOperand = value
            print("leftOperand = \(leftOperand)")
        } else if rightOperand == nil {
            rightOperand = value
            print("rightOperand = \(rightOperand)")
        }
    }
    
    func binary(operation: BinaryOperation) {
        switch operation {
        case .Plus:
            resultValue = (leftOperand ?? 0.0) + (rightOperand ?? 0.0)
            temp = operation.rawValue
            print("Plus")
        case .Minus:
            resultValue = (leftOperand ?? 0.0) - (rightOperand ?? 0.0)
            temp = operation.rawValue
            print("Minus")
        case .Mul:
            resultValue = (leftOperand ?? 0.0) * (rightOperand ?? 0.0)
            temp = operation.rawValue
            print("Multiply")
        case .Div:
            resultValue = (leftOperand ?? 0.0) / (rightOperand ?? 0.0)
            temp = operation.rawValue
            print("Divide")
        default: break
        }
    }
    
    func unary(operation: UnaryOperation) {
        switch operation {
        case .Sqrt:
            leftOperand = (sqrt(leftOperand ?? 0.0 ))
            temp = operation.rawValue
            print("Squre root = \(leftOperand)" )
        case .Cos:
            leftOperand = (cos(leftOperand ?? 0.0 ))
            temp = operation.rawValue
            print("Cos = \(leftOperand)")
        case .Sin:
            leftOperand = (sin(leftOperand ?? 0.0 ))
            temp = operation.rawValue
            print("Sin = \(leftOperand)")
        }
    }
    
    func utility(operation: UtilityOperation) {
        switch operation {
        case .Equal:
            switch temp! {
            case "-" :
                leftOperand = leftOperand! - rightOperand!
                print("result = \(leftOperand)")
                rightOperand = nil
            case "+" :
                leftOperand = leftOperand! + rightOperand!
                print("result = \(leftOperand)")
                rightOperand = nil
            case "*" :
                leftOperand = leftOperand! * rightOperand!
                print("result = \(leftOperand)")
                rightOperand = nil
            case "/" :
                leftOperand = leftOperand! / rightOperand!
                print("result = \(leftOperand)")
                rightOperand = nil
            default:
                break
                
            }
        case .Clean:
            resultValue = 0.0
            leftOperand = nil
            rightOperand = nil
        case .Dot:
            break
        default:
            break
        }
    }
}
