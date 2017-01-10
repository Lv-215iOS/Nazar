//
//  CalcProtocols.swift
//  MyCalc
//
//  Created by AdminAccount on 1/5/17.
//  Copyright © 2017 AdminAccount. All rights reserved.
//

import Foundation

enum BinaryOperation : String {
    case Plus = "+"
    case Minus = "-"
    case Mul = "*"
    case Div = "/"
    case Power = "^"
    case Mod = "%"
}

enum UtilityOperation : String {
    case RightBracket = ")"
    case LeftBracket = "("
    case Dot = "."
    case Equal = "="
    case Clean = "C"
    case MPlus = "M+"
    case MMinus = "M-"
    case MClear = "MC"
    case MRead = "MR"
}

enum UnaryOperation : String {
    case Sin = "sin"
    case Cos = "cos"
    case Sqrt = "sqrt"
    case Tg = "tg"
    case Ctg = "ctg"
    case Ln = "ln"
    case Log = "log"
    case Sinh = "sinh"
    case Cosh = "cosh"
    case Tgh = "tgh"
    case Ctgh = "ctgh"
    case Fact = "!"
}

protocol CalcBrainInterface {
    func digit(value: Double)
    func binary(operation: BinaryOperation)
    func unary(operation: UnaryOperation)
    func utility(operation: UtilityOperation)
    var result: ((Double?, Error?)->())? {get set}
}

protocol OutputInterface {
    func outputInfo(info: String?)
}

protocol InputInterface {
    var buttonDidPress: ((_ operation: String)->())? {get set}
}
