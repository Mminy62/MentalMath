//
//  CalculateViewModel.swift
//  MentalMath
//
//  Created by 이민영 on 8/29/24.
//

import Foundation
import SwiftUI

class CalculateViewModel: ObservableObject {
    static let shared = CalculateViewModel()
    
    @Published var textLineColor: Color = .black
    @Published var selectedLeftNumber: Int = 1
    @Published var selectedRightNumber: Int = 1
    @Published var leftNumber: Int = 1
    @Published var rightNumber: Int = 1
    @Published var op: Operator = .add
    @Published var isCorrect: Bool = false
    @Published var problem: String = ""
    @Published var answer: String = "1"
    @Published var destination: Destination = .multable
    @Published var userAnswer: String = "" {
        didSet {
            if oldValue != userAnswer {
                checkAnswer()
            }
        }
    }
    @Published var onAutoMode = false {
        didSet {
            checkAnswer()
        }
    }
    
    private var leftStartNum: Int = 1
    private var leftEndNum: Int = 1
    private var rightStartNum: Int = 1
    private var rightEndNum: Int = 1
    private let defaultEndNumber: Int = 9
    private let autoDelay: TimeInterval = 0.5

    // MARK: initNumbers - 화면 초기에 숫자 세팅 함수
    func initNumbers() {
        if op == .div && selectedLeftNumber < selectedRightNumber {
            swap(&selectedLeftNumber, &selectedRightNumber)
            leftStartNum = Int(pow(10.0, Float(selectedLeftNumber - 1)))
            leftEndNum = leftStartNum * 10 - 1
            rightStartNum = Int(pow(10.0, Float(selectedRightNumber - 1)))
            rightEndNum = rightStartNum * 10 - 1
        }
        else if destination == .multable {
            leftStartNum = selectedLeftNumber
            leftEndNum = selectedLeftNumber
            rightStartNum = 1
            rightEndNum = selectedLeftNumber > 9 ? selectedLeftNumber : defaultEndNumber
        } else {
            leftStartNum = Int(pow(10.0, Float(selectedLeftNumber - 1)))
            leftEndNum = leftStartNum * 10 - 1
            rightStartNum = Int(pow(10.0, Float(selectedRightNumber - 1)))
            rightEndNum = rightStartNum * 10 - 1
        }
        
        setNextProblem()
    }
    
    // MARK: setNextProblem - 다음 문제 생성 함수
    func setNextProblem() {
        switch op {
        case .add, .mul, .sub:
            if destination == .multable {
                leftNumber = createNumber(oldValue: nil, start: leftStartNum, end: leftEndNum)
                rightNumber = createNumber(oldValue: rightNumber, start: rightStartNum, end: rightEndNum)
            } else {
                leftNumber = createNumber(oldValue: leftNumber, start: leftStartNum, end: leftEndNum)
                rightNumber = createNumber(oldValue: rightNumber, start: rightStartNum, end: rightEndNum)
            }
            if op == .sub {
                if leftNumber < rightNumber { swap(&leftNumber, &rightNumber) }
            }
            
            createProblem()
            
        case .div:
            print("div:", leftNumber, rightNumber)
            if leftNumber < rightNumber {
                swap(&leftNumber, &rightNumber)
            }
            setDivProblem()
        }
    }

    // MARK: setDivProblem - div 연산자의 다음 문제 생성 함수
    func setDivProblem() {
        var tempAnswer = 0
        while true {
            let temp1 = createNumber(oldValue: nil, start: leftStartNum, end: leftEndNum)
            let temp2 = createNumber(oldValue: nil, start: rightStartNum, end: rightEndNum)
            let maxValue = max(temp1, temp2)
            let minValue = min(temp1, temp2)
            
            if leftNumber == maxValue { continue }
            leftNumber = maxValue
            rightNumber = minValue

            let originDigits = String(leftNumber).count
            tempAnswer = leftNumber / rightNumber
            leftNumber = rightNumber * tempAnswer
        
            // 검산
            let resultDigit = String(leftNumber).count
            if resultDigit < originDigits {
                tempAnswer += 1
                leftNumber = tempAnswer * rightNumber
            }
            if resultDigit == originDigits {
                break
            }
        }
        answer = String(tempAnswer)
        createProblem()
    }
    
    // MARK: createProblem - 문제, 답안 문자열 생성 함수
    func createProblem() {
        if !userAnswer.isEmpty { userAnswer = "" }
        
        if op == .div {
            problem = "\(leftNumber) \(op.display) \(rightNumber) = "
            print("Result div:", answer)
            return
        }
    
        problem = "\(leftNumber) \(op.display) \(rightNumber) = "
        let NSProblem = "\(leftNumber)\(op.rawValue)\(rightNumber)"
        let expression = NSExpression(format: NSProblem)
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber
        {
            answer = result.stringValue
            print("Result:", result)
        }
    }
    
    // MARK: createNumber - random 숫자 생성 함수
    func createNumber(oldValue: Int?, start: Int, end: Int) -> Int {
        var newNumber = 0
        
        if let oldValue {
            while true {
                newNumber = Int.random(in: start...end)
                if newNumber != oldValue { break }
            }
        } else {
            newNumber = Int.random(in: start...end)
        }
        
        return newNumber
    }
    
    // MARK: checkAnswer - 정답이 맞는지 확인하는 함수
    // textfield line color & isCorrect flag 확인
    private func checkAnswer() {
        if userAnswer.isEmpty {
            textLineColor = .primary
            isCorrect = false
        } else {
            if answer == userAnswer {
                isCorrect = true
                textLineColor = Color.mainCyan
            } else {
                isCorrect = false
                textLineColor = .red
            }
        }
        
        if onAutoMode && isCorrect {
            DispatchQueue.main.asyncAfter(deadline: .now() + autoDelay) {
                self.setNextProblem()
            }
        }
    }
}
