//
//  NumberListView.swift
//  MathMastery
//
//  Created by 이민영 on 8/29/24.
//

import SwiftUI

struct NumberListView: View {
    private let startRange = 2
    private let endRange = 20

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(startRange...endRange), id: \.self) { num in
                    NavigationLink(destination: CalculateView(selectedNumber: num)) {
                        Text("\(num)")
                            .font(.system(size: 20))
                    }
                }
            }
            .navigationTitle("Multiplication Table")
        }
    }
}

#Preview {
    NumberListView()
}
