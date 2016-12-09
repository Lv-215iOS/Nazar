//
//  CalculatorBrain.swift
//  MyCalc
//
//  Created by AdminAccount on 12/7/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import Foundation
//commentvb
enum Optional<T>{
    case None
    case Some(T)
    
}

class CalculatorBrain{
    private var accumulator: Double = 0.0 //accumulate the result

    func setOperand(operand: Double){
    accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        
        "π": Operation.Constant(M_PI),
        "√": Operation.UnaryOperation(sqrt), //sqrt
        "cos": Operation.UnaryOperation(cos),//cos
        "sin": Operation.UnaryOperation(sin),//sin
        "+": Operation.BinaryOperation({$0+$1}),
        "-": Operation.BinaryOperation({$0-$1}),
        "x ": Operation.BinaryOperation({$0*$1}),
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
