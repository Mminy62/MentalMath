//
//  MulTableView.swift
//  MentalMath
//
//  Created by 이민영 on 8/29/24.
//

import SwiftUI

struct MulTableView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel = CalculateViewModel.shared
    private let startRange = 2
    private let endRange = 20
    private var selectedNumber: Int = 0
    var body: some View {
        VStack {
            List {
                ForEach(Array(startRange...endRange), id: \.self) { num in
                    Button(action: {
                        viewModel.selectedLeftNumber = num
                        viewModel.destination = .multable
                        router.navigate(to: .calculate("\(num)th Problems"))
                    }, label: {
                        Text("\(num)")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    })
                }
            }
            .listStyle(PlainListStyle())
        }
        .toolbarStyle(title: "Multiplication Table", onAutoButton: false)
        .background(Color.white)
        .padding(10)
    }
}

#Preview {
    MulTableView()
}
