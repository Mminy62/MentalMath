//
//  MulTableView.swift
//  MentalMath
//
//  Created by 이민영 on 8/29/24.
//

import SwiftUI

struct MulTableView: View {
    private let startRange = 2
    private let endRange = 20
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(startRange...endRange), id: \.self) { num in
                    NavigationLink(destination: CalculateView(selectedNumber: num)) {
                        Text("\(num)")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
            }
            .navigationTitle("Multiplication Table")
            .listStyle(PlainListStyle()) // 기본 스타일로 설정 (옵션)
            .background(Color.white) // 배경색 설정
            .padding() // 여백 추가
        }
    }
}

#Preview {
    MulTableView()
}
