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
    let selectedNumber: Int
    let screenWidth = UIScreen.main.bounds.width
    
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            VStack(alignment: .center, spacing: 30){
                HStack(alignment: .center) {
                    Spacer()
                    Text("\(viewModel.leftNumber) X \(viewModel.rightNumber) = ")
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
                        viewModel.settingNextProblem()
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView()
            }
            ToolbarItem(placement: .principal) {
                Text("\(selectedNumber)th Problems")
                    .bold()
                    .font(.system(size: 20))
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                Toggle(isOn: $viewModel.onAutoMode){
                    Text("Auto")
                        .bold()
                }
                .padding(.trailing, 15)
                .tint(Color.nextBackground)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .onAppear {
            // viewModel 설정
            viewModel.selectedNumber = selectedNumber
            viewModel.settingNumbers()
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
