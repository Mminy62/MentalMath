//
//  CalculateView.swift
//  MathMastery
//
//  Created by 이민영 on 8/29/24.
//

import SwiftUI

struct CalculateView: View {
    @ObservedObject var viewModel = MultipleViewModel.shared
    let selectedNumber: Int

    var body: some View {
        VStack {
            Text("Selected Number: \(viewModel.selectedNumber)")
        }
        .onAppear {
            viewModel.selectedNumber = selectedNumber
        }
    }
}

#Preview {
    CalculateView(selectedNumber: 1)
}
