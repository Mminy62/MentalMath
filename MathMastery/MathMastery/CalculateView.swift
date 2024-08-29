//
//  CalculateView.swift
//  MathMastery
//
//  Created by 이민영 on 8/29/24.
//

import SwiftUI

struct CalculateView: View {
    @ObservedObject var viewModel = MultipleViewModel.shared
    @FocusState var isFocused: Bool
    let selectedNumber: Int

    var body: some View {
        VStack(spacing: 30) {
            HStack(alignment: .center) {
                    Text("\(viewModel.leftNumber) X \(viewModel.rightNumber) = ")
                        .boldTextStyle()
                    
                    TextField("정답칸", text: $viewModel.userAnswer, prompt: Text("Answer").foregroundStyle(Color.textField))
                        .boldTextStyle()
                        .textFieldUnderbarStyle(lineColor: viewModel.textLineColor)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                        .frame(width: 100)
            }
            
            HStack(alignment: .center, spacing: 50) {
                Button(action: {
                    viewModel.userAnswer = viewModel.answer
                }, label: {
                        Text("Hint")
                            .commomButtonStyle(backgroundColor: Color.hintBackground)
                    })
                    
                Button(action: {
                    viewModel.settingNextProblem()
                }, label: {
                        Text("Next")
                            .commomButtonStyle(backgroundColor: Color.nextBackground)
                    })
                }
        }
        .navigationBarTitle("\(selectedNumber)th Problems", displayMode: .inline)
        .onAppear {
            viewModel.selectedNumber = selectedNumber
            viewModel.settingNumbers()
        }
        .onDisappear {
            isFocused = false
            viewModel.userAnswer = ""
        }
    }
}

#Preview {
    CalculateView(selectedNumber: 1)
}
