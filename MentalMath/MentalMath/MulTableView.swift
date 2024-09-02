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
        VStack {
            List {
                ForEach(Array(startRange...endRange), id: \.self) { num in
                    NavigationLink(destination: CalculateView(selectedNumber: num)) {
                        Text("\(num)")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .toolbarStyle(title: "Multiplication Table", onAutoButton: false)
        .background(Color.white) // 배경색 설정
        .padding(10)
    }
}

#Preview {
    MulTableView()
}
