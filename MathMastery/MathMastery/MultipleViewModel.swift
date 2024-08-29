//
//  MultipleViewModel.swift
//  MathMastery
//
//  Created by 이민영 on 8/29/24.
//

import Foundation

class MultipleViewModel: ObservableObject {
    static let shared = MultipleViewModel()
    
    @Published var selectedNumber: Int = 1
    
    private init() {} // 외부에서 새로운 인스턴스 생성을 막음
    
    func settingEndNumber(_ number: Int) -> Int {
        var endNumber: Int = 9
        endNumber =  selectedNumber > 9 ?  number : endNumber
        return endNumber
    }
    
    func getRandomNumber(_ endNumber: Int) -> Int {
        return Int.random(in: 1...endNumber)
    }
}
