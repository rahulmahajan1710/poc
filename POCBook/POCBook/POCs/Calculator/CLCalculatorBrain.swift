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
    private var internalProgram = [Any]()
    var result : Double {
        get{
            return accumulator
        }
    }
    
    func addUnaryOperation(symbol : String , operation : @escaping (Double)-> Double){
        operations[symbol] = Operation.UnaryOperation(operation)
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
    
    
    typealias PropertyList = Any
    
    var program : PropertyList {
        set{
            clear()
            if let arrayOfOps = newValue as? [Any] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        print(operand)
                        setOperand(operand: operand)
                    }
                    else if let operation = op as? String{
                        print(operation)
                        performOperation(symbol: operation)
                    }
                }
            }
        }
        get{
            return internalProgram
        }
    }
    
    private func clear(){
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    func setOperand(operand :Double)  {
        accumulator = operand
        internalProgram.append(operand)
    }
    
    func performOperation(symbol : String) {
        internalProgram.append(symbol)
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
    
    

}
