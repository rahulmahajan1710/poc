//
//  CLCalculatorBrain.swift
//  POCBook
//
//  Created by rahul mahajan on 27/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

class CLCalculatorBrain {
    private var accumulator = 0.0
    
    var result : Double {
        get{
            return accumulator
        }
    }
    
    private var operations = [ "π" : Operation.Constant(M_PI),
                               "√" : Operation.UnaryOperation(sqrt),
                               "=" : Operation.Equals,
                               "➕" : Operation.BinaryOperation{$0 + $1},
                               "✖️" : Operation.BinaryOperation{$0 * $1},
                               "➖" : Operation.BinaryOperation{$0 - $1}]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction : (Double,Double) -> Double
        var firstOperand : Double
    }
    private var pending : PendingBinaryOperationInfo?
    
    
    func performOperation(symbol : String) {
        if let operation = operations[symbol] {
            switch  operation{
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let foo) :
                accumulator = foo(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperatio()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals :
               executePendingBinaryOperatio()
            }
        }
    }
    
    private func executePendingBinaryOperatio(){
        if  pending !=  nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    func setOperand(operand :Double)  {
        accumulator = operand
    }

}
