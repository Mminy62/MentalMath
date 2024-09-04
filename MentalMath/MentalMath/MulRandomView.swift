//
//  MulRandomView.swift
//  MentalMath
//
//  Created by 이민영 on 9/2/24.
//

import SwiftUI

struct MulRandomView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel = CalculateViewModel.shared
    @State var leftNumber: Int = 0
    @State var rightNumber: Int = 0
    @State private var showLeftPicker = false
    @State private var showRightPicker = false
    @State var onNext: Bool = false
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Text("Set the number of digits")
                .boldTextStyle()
            
            HStack {
                Button(action: {
                    showLeftPicker.toggle()
                    
                }, label: {
                    Text(leftNumber == 0 ? "Digit" : "\(String(describing: leftNumber)) digits")
                        .foregroundStyle(leftNumber == 0 ? .textField : .black)
                        .textFieldUnderbarStyle(lineColor: .black)
                        .boldTextStyle()
                })
                .padding()
                .sheet(isPresented: $showLeftPicker) {
                    PickerView(number: $leftNumber)
                }
                
                Text(viewModel.op.display)
                    .boldTextStyle()
                
                Button(action: {
                    showRightPicker.toggle()
                    
                }, label: {
                    Text(rightNumber == 0 ? "Digit" : "\(String(describing: rightNumber)) digits")
                        .foregroundStyle(rightNumber == 0 ? .textField : .black)
                        .textFieldUnderbarStyle(lineColor: .black)
                        .boldTextStyle()
                })
                .padding()
                .sheet(isPresented: $showRightPicker) {
                    PickerView(number: $rightNumber)
                }
            }
            
            Button(action: {
                viewModel.selectedLeftNumber = leftNumber
                viewModel.selectedRightNumber = rightNumber
                viewModel.destination = .mulrandom
                router.navigate(to: .calculate("Random Problems"))
            }, label: {
                Text("Next")
                    .commomButtonStyle(textColor: Color.nextButtonText, backgroundColor: Color.mainPurple)
            })
            .opacity(leftNumber != 0 && rightNumber != 0 ? 1 : 0.7)
            .disabled(leftNumber == 0 || rightNumber == 0)
        }
        .toolbarStyle(title: "Random", onAutoButton: false)
        
    }
}

struct PickerView: View {
    @Binding var number: Int
    let numberRange: [Int] = [1, 2, 3, 4]
    
    var body: some View {
        VStack {
            Picker("Pick", selection: $number) {
                ForEach(numberRange, id: \.self) { idx in
                    Text("\(idx) digits")
                }
                .cornerRadius(15)
                .padding()
            }
            .pickerStyle(.wheel)
            .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    MulRandomView()
}
