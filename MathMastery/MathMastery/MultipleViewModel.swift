//
//  MultipleViewModel.swift
//  MathMastery
//
//  Created by 이민영 on 8/29/24.
//

import Foundation
import SwiftUI

class MultipleViewModel: ObservableObject {
    static let shared = MultipleViewModel()
    @Published var selectedNumber: Int = 1
    @Published var leftNumber: Int = 1
    @Published var rightNumber: Int = 1
    @Published var answer: String = "1"
    @Published var userAnswer: String = "" {
        didSet {
            checkAnswer()
        }
    }
    @Published var textLineColor: Color = .black
    var endNumber: Int = 9
    
    
    private init() { // 외부에서 새로운 인스턴스 생성을 막음
    }
    
    func settingNumbers() {
        endNumber = selectedNumber > 9 ? selectedNumber : endNumber
        leftNumber = selectedNumber
        rightNumber = Int.random(in: 1...endNumber)
        answer = String(leftNumber * rightNumber)
    }
    
    func settingNextProblem() {
        rightNumber = Int.random(in: 1...endNumber)
        answer = String(leftNumber * rightNumber)
        userAnswer = ""
    }
    
    private func checkAnswer() {
        if userAnswer.isEmpty {
            textLineColor = .black
        } else {
            textLineColor = answer != userAnswer ? .red : Color.hintBackground
        }
    }
}
