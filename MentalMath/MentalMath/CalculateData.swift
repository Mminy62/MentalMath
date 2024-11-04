//
//  CalculateData.swift
//  MentalMath
//
//  Created by 이민영 on 11/4/24.
//

import Foundation

class CalculateData: ObservableObject {
    var leftNumber: Int
    var rightNumber: Int
    var op: Operator
    var destination: Destination
    
    init() {
        self.leftNumber = 1
        self.rightNumber = 1
        self.op = .add
        self.destination = .multable
    }
}
