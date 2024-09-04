//
//  CalculateView.swift
//  MentalMath
//
//  Created by 이민영 on 8/29/24.
//

import SwiftUI

struct CalculateView: View {
    @ObservedObject var viewModel = CalculateViewModel.shared
    @FocusState var isFocused: Bool
    let selectedNumber: Int?
    let screenWidth = UIScreen.main.bounds.width
    
    @State private var onAuto: Bool = false // Create the state.
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            VStack(alignment: .center, spacing: 30){
                HStack(alignment: .center) {
                    Spacer()
                    Text(viewModel.problem)
                        .boldTextStyle()
                        .foregroundStyle(.primary)
                    
                    TextField("정답란", text: $viewModel.userAnswer, prompt: Text("Answer").foregroundColor(Color.textField))
                        .boldTextStyle()
                        .textFieldUnderbarStyle(lineColor: viewModel.textLineColor)
                    
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                        .padding(.bottom, 5)
                        .frame(maxWidth: 130)
                    Spacer()
                }
                
                HStack(alignment: .center, spacing: 60) {
                    Spacer(minLength: 100)
                    Button(action: {
                        viewModel.userAnswer = viewModel.answer
                    }, label: {
                        Text("Hint")
                            .commomButtonStyle(textColor: Color.hintButtonText,backgroundColor: Color.mainCyan)
                    })
                    .frame(width: screenWidth/5, height: 35)
                    
                    Button(action: {
                        viewModel.setNextProblem()
                    }, label: {
                        Text("Next")
                            .commomButtonStyle(textColor: Color.nextButtonText ,backgroundColor: Color.mainPurple)
                            .opacity(viewModel.onAutoMode ? 0 : 1)
                    })
                    .frame(width: screenWidth/5, height: 35)
                    Spacer(minLength: 100)
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbarStyle(title: "\(selectedNumber ?? 0)th Problems", onAutoButton: true)
        .onAppear {
            viewModel.selectedLeftNumber = selectedNumber ?? 0
            viewModel.initNumbers()
            print(viewModel.op)
        }
        .onDisappear {
            viewModel.userAnswer = ""
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    CalculateView(selectedNumber: 14)
}
