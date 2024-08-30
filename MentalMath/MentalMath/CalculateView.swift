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
    
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            VStack(alignment: .center, spacing: 30){
                HStack(alignment: .center) {
                    Text("\(viewModel.leftNumber) X \(viewModel.rightNumber) = ")
                        .boldTextStyle()
                    
                    TextField("정답란", text: $viewModel.userAnswer, prompt: Text("Answer").foregroundColor(Color.textField))
                        .boldTextStyle()
                        .textFieldUnderbarStyle(lineColor: viewModel.textLineColor)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                        .padding(.bottom, 5)
                }
                .padding(.leading, 100)
                .padding(.trailing, 100)
                
                HStack(alignment: .center) {
                    Button(action: {
                        viewModel.userAnswer = viewModel.answer
                    }, label: {
                        Text("Hint")
                            .commomButtonStyle(backgroundColor: Color.hintBackground)
                    })
                    .frame(height: 35)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.settingNextProblem()
                    }, label: {
                        Text("Next")
                            .commomButtonStyle(backgroundColor: Color.nextBackground)
                            .opacity(viewModel.onAutoMode ? 0 : 1)
                    })
                    .frame(height: 35)
                }
                .padding(.leading, 100)
                .padding(.trailing, 100)
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
    CalculateView(selectedNumber: 1)
}
