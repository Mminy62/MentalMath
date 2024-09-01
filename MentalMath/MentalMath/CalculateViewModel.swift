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

    private init() {} // 외부에서 새로운 인스턴스 생성을 막음
    
    func settingNumbers() {
        endNumber = selectedNumber > 9 ? selectedNumber : endNumber
        leftNumber = selectedNumber
        rightNumber = Int.random(in: 1...endNumber)
        answer = String(leftNumber * rightNumber)
    }
    
    func settingNextProblem() {
        userAnswer = ""
        rightNumber = Int.random(in: 1...endNumber)
        answer = String(leftNumber * rightNumber)
    }
    
    // textfield line color & isCorrect flag 담당
    private func checkAnswer() {
        if userAnswer.isEmpty {
            textLineColor = .black
            isCorrect = false
        } else {
            if answer == userAnswer {
                isCorrect = true
                textLineColor = Color.hintBackground
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
