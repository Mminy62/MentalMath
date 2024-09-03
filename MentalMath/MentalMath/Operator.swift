//
//  Operator.swift
//  MentalMath
//
//  Created by 이민영 on 9/3/24.
//

import Foundation

enum Operator: String {
    case mul = "*"
    case add = "+"
    case div = "/"
    case sub = "-"
    
    var display: String {
        switch self {
        case .mul:
            return "X"
        case .add:
            return "+"
        case .div:
            return "÷"
        case .sub:
            return "-"
        }
    }
}
