//
//  CalculatorBrain.swift
//  MyCalc
//
//  Created by AdminAccount on 12/7/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import Foundation

enum binaryOperation: String {
    case Plus = "+"
    case Minus = "-"
    case Mul = "*"
    case Div = "/"
}

enum utilityOperation: String {
    case Dot = "."
    case Equal = "="
}

enum unaryOperation: String {
    case Cos = "cos"
    case Sqrt = "Sqrt"
}

protocol CalcBrainInterface {
    func digit(value: Double)
    func binary(operation: binaryOperation)
    func unary(operation: unaryOperation)
    var result: ((Double?, Error?) -> ())? {get set}
    //var result: Double {get}
}

class CalculatorBrain {

    var result: ((Double?, Error?)->())? = nil
    var leftOperand: Double?
    var rightOperand: Double?
    //var currentOperand: Double?
    var resultValue: Double?
    var temp: String? = nil
    //var outputController : OutputViewController? = nil

    
    func digit(value: Double) {
        if leftOperand == nil {
            leftOperand = value
            
        } else if rightOperand == nil {
            rightOperand = value
        }
    }
    
    func binary(operation: binaryOperation) {
        switch operation {
        case .Plus:
            resultValue = (leftOperand ?? 0.0) + (rightOperand ?? 0.0)
            //outputController?.outputInfo(info: operation.rawValue)
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
        }
    }

    func unary(operation: unaryOperation) {
       
    }
    
    func utility(operation: utilityOperation) {
        switch operation {
        case .Equal:
            switch temp! {
            case "-" :
                leftOperand = leftOperand! - rightOperand!
                print("\(leftOperand)")
                rightOperand = nil
            case "+" :
                leftOperand = leftOperand! + rightOperand!
                print("\(leftOperand)")
                rightOperand = nil
            case "*" :
                resultValue = leftOperand! * rightOperand!
                print("\(resultValue)")
            case "/" :
                resultValue = leftOperand! / rightOperand!
                print("\(resultValue)")
            default:
                break
            }default:
               break
        }
    }
}


