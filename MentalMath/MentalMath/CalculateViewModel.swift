//
//  MultipleViewModel.swift
//  MentalMath
//
//  Created by 이민영 on 8/29/24.
//

import Foundation
import SwiftUI

class CalculateViewModel: ObservableObject {
    static let shared = CalculateViewModel()
    
    @Published var textLineColor: Color = .black
    @Published var onAutoMode = false {
        didSet {
            checkAnswer()
        }
    }
    
    @Published var selectedNumber: Int = 1
    @Published var leftNumber: Int = 1
    @Published var rightNumber: Int = 1
    @Published var op: String = "+"
    @Published var isCorrect: Bool = false
    @Published var answer: String = "1"
    @Published var userAnswer: String = "" {
        didSet {
            if oldValue != userAnswer {
                checkAnswer()
            }
        }
    }
    
    private var endNumber: Int = 9
    
    // 상수 정리
    private let defaultEndNumber: Int = 9
    private let autoDelay: TimeInterval = 1.0

    private init() {} // 외부에서 새로운 인스턴스 생성을 막음
    
    func settingNumbers() {
        endNumber = selectedNumber > 9 ? selectedNumber : endNumber
        leftNumber = selectedNumber
        rightNumber = createNumber(oldValue: rightNumber)
        answer = String(leftNumber * rightNumber)
    }
    
    func settingNextProblem() {
        userAnswer = ""
        rightNumber = createNumber(oldValue: rightNumber)
        answer = String(leftNumber * rightNumber)
    }
    
    func createNumber(oldValue: Int) -> Int {
        var newNumber = 0
        
        while true {
            newNumber = Int.random(in: 1...endNumber)
            if newNumber != oldValue { break }
        }
        return newNumber
    }
    
    // textfield line color & isCorrect flag 담당
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.settingNextProblem()
            }
        }
    }
}
