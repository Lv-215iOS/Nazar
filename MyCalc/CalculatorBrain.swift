//
//  CalculatorBrain.swift
//  MyCalc
//
//  Created by AdminAccount on 12/7/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import Foundation
//commentvbrft
enum Optional<T>{
    case None
    case Some(T)
    
}

enum BinaryOperation : String{
    case Plus = "+"
    case Minus = "-"
    case Mul = "x"
    case Div = "÷"
    //case Power = "^"
    //case Mod = "%"
}

enum UtilityOperation : String{
    //case RightBracket = ")"
    //case LeftBracket = "("
    case Dot = "."
    case Equal = "="
}

enum UnaryOperation : String{
    case Sin = "sin"
    case Cos = "cos"
    case Sqrt = "sqrt"
}


protocol CalcBrainInterface {
    func digit(value: Double)
    func binary(operation: BinaryOperation)
    func unary(operation: UnaryOperation)
    func utility(operation: UtilityOperation)
    var result: ((Double?, Error?)->())? {get set}
}


class CalculatorBrain{
    private var accumulator: Double = 0.0 //accumulate the result

    func setOperand(operand: Double){
    accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        
      
        "√": Operation.UnaryOperation(sqrt), //sqrt
        "cos": Operation.UnaryOperation(cos),//cos
        "sin": Operation.UnaryOperation(sin),//sin
        "+": Operation.BinaryOperation({$0+$1}),
        "-": Operation.BinaryOperation({$0-$1}),
        "x": Operation.BinaryOperation({$0*$1}),
        "÷": Operation.BinaryOperation({$0/$1}),
        "=": Operation.BinaryOperation({$0+$1}),
        ".": Operation.BinaryOperation({pow($0, $1)})
 
    ]
    private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double, Double)->Double)
        case Equals
    }
    
   func performOperation(symbol: String){
    if let operation = operations[symbol]{
        switch operation {
        case .Constant(let value):
            accumulator = value
        case .UnaryOperation(let function):
            accumulator = function(accumulator)
        case .BinaryOperation(let function):
            executePendingBinaryOperation()
            pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
        case .Equals:
    executePendingBinaryOperation()
        
             }
         }
    }
    private func executePendingBinaryOperation(){
        if pending != nil {
            
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }

    }
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo{
        
        var binaryFunction:(Double,Double)->Double
        var firstOperand:Double
        
    }
    
    var result: Double{
        get{
            return accumulator
        }
    }
    
    
}
