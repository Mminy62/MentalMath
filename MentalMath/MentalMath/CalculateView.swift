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
    var leftNum: Int = 1
    var rightNum: Int = 1
    var title: String
    private let screenWidth = UIScreen.main.bounds.width
    
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
//                        .frame(width: screenWidth/4)
                    Spacer()
                }
                .frame(width: screenWidth * 0.6)
                
                HStack(alignment: .center) {
                    Button(action: {
                        viewModel.userAnswer = viewModel.answer
                    }, label: {
                        Text("Hint")
                            .commomButtonStyle(textColor: Color.hintButtonText,backgroundColor: Color.hintBackground)
                    })
                    .frame(width: screenWidth/4, height: 35)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.setNextProblem()
                    }, label: {
                        Text("Next")
                            .commomButtonStyle(textColor: Color.nextButtonText ,backgroundColor: Color.mainPurple)
                            .opacity(viewModel.onAutoMode ? 0 : 1)
                    })
                    .frame(width:screenWidth/4, height: 35)
                }
                .frame(width: screenWidth * 0.6)
            }
            .frame(width: screenWidth * 0.6)
        }
        .navigationBarBackButtonHidden(true)
        .toolbarStyle(title: title, onAutoButton: true)
        .onAppear {
            viewModel.initNumbers()
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
    CalculateView(title: "3th Problems")
}
