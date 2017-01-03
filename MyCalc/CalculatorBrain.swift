//
//  CalculatorBrain.swift
//  MyCalc
//
//  Created by AdminAccount on 12/7/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import UIKit

class CalculatorBrain: CalcBrainInterface {
    
    var accumulatorValue: Double?
    var temp: String? = nil
    var pending: PendingBinaryOperationInfo?
    var result: ((Double?, Error?)->())? = nil
    var operations: Dictionary <String, Operation> = [
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "sin": Operation.UnaryOperation(sin),
        "tg" : Operation.UnaryOperation(tan),
        "ctg": Operation.UnaryOperation({1 / tan($0)}),
        "log": Operation.UnaryOperation(log2),
        "*": Operation.BinaryOperation({ $0 * $1 }),
        "/": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "-": Operation.BinaryOperation({ $0 - $1 }),
        "^": Operation.BinaryOperation({pow($0, $1)}),
        "=": Operation.Equals
    ]
    
    enum Operation {
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var fistOperand: Double
    }
    
    func executePendingBinaryOperation() {
        if pending != nil {
            accumulatorValue = pending!.binaryFunction(pending!.fistOperand, accumulatorValue!)
            pending = nil
        }
    }
    
    func digit(value: Double) {
        accumulatorValue = value
    }
    
    func utility(operation: UtilityOperation) {
        if let operationSymbol = operations[operation.rawValue] {
            switch operationSymbol {
            case .Equals:
                executePendingBinaryOperation()
                result?(accumulatorValue, nil)
            default:
                break
            }
        }
    }
    
    func unary(operation: UnaryOperation) {
        if let operationSymbol = operations[operation.rawValue] {
            switch operationSymbol {
            case .UnaryOperation(let function):
                accumulatorValue = function(accumulatorValue!)
                result?(accumulatorValue, nil)
            default:
                break
            }
        }
    }
    
    func binary(operation: BinaryOperation) {
        if let operationSymbol = operations[operation.rawValue] {
            switch operationSymbol {
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, fistOperand: accumulatorValue!)
            default:
                break
            }
        }
    }
    
    func perform0peration(symbol: String) {
        if BinaryOperation(rawValue: symbol) != nil {
            let possibleBinary = BinaryOperation(rawValue: symbol)
            self.binary(operation: possibleBinary!)
        } else if UnaryOperation(rawValue: symbol) != nil {
            let possibleUnary = UnaryOperation(rawValue: symbol)
            self.unary(operation: possibleUnary!)
        } else if UtilityOperation(rawValue: symbol) != nil {
            let possibleUtility = UtilityOperation(rawValue: symbol)
            self.utility(operation: possibleUtility!)
        }
    }
    
    func clear() {
        accumulatorValue = 0.0
    }
}
