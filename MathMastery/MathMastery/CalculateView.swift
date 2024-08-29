//
//  CalculateView.swift
//  MathMastery
//
//  Created by 이민영 on 8/29/24.
//

import SwiftUI

struct CalculateView: View {
    @ObservedObject var viewModel = MultipleViewModel.shared
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FocusState var isFocused: Bool
    let selectedNumber: Int

    var backButton : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                Text("Back")
            }
            .foregroundStyle(.black)
            .bold()
        }
    }
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            VStack(spacing: 30){
                HStack(alignment: .center) {
                    Text("\(viewModel.leftNumber) X \(viewModel.rightNumber) = ")
                        .boldTextStyle()
                    
                    TextField("정답란", text: $viewModel.userAnswer, prompt: Text("Answer").foregroundStyle(Color.textField))
                        .boldTextStyle()
                        .textFieldUnderbarStyle(lineColor: viewModel.textLineColor)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                        .frame(width: 100)
                        .padding(.bottom, 5)
                }
                
                HStack(alignment: .center, spacing: 20) {
                    Button(action: {
                        viewModel.userAnswer = viewModel.answer
                    }, label: {
                        Text("Hint")
                            .commomButtonStyle(backgroundColor: Color.hintBackground)
                    })
                    .frame(width: 100, height: 35)
                    
                    Button(action: {
                        viewModel.settingNextProblem()
                    }, label: {
                        Text("Next")
                            .commomButtonStyle(backgroundColor: Color.nextBackground)
                    })
                    .frame(width: 100, height: 35)
                }
            }
        }
        .navigationBarTitle("\(selectedNumber)th Problems", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
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
