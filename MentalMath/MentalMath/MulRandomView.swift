//
//  MulRandomView.swift
//  MentalMath
//
//  Created by 이민영 on 9/2/24.
//

import SwiftUI

struct MulRandomView: View {
    @ObservedObject var viewModel = CalculateViewModel.shared
    @State var selectedLeftNumber: Int = 0
    @State var selectedRightNumber: Int = 0
    @State private var showLeftPicker = false
    @State private var showRightPicker = false
    let numberRange: [Int] = [1, 10, 100, 1000]
    @State var leftNumber: String = "Digit"
    @State var onNext: Bool = false
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Text("Set the number of digits")
                .boldTextStyle()
            
            HStack {
                Button(action: {
                    showLeftPicker.toggle()
                    
                }, label: {
                    Text(selectedLeftNumber == 0 ? "Digit" : "\(String(describing: selectedLeftNumber))")
                        .foregroundStyle(.gray)
                        .textFieldUnderbarStyle(lineColor: .black)
                        .boldTextStyle()
                })
                .padding()
                .sheet(isPresented: $showLeftPicker) {
                    PickerView(number: $selectedLeftNumber)
                }
                
                Text(viewModel.op.display)
                    .boldTextStyle()
                
                Button(action: {
                    showRightPicker.toggle()
                    
                }, label: {
                    Text(selectedRightNumber == 0 ? "Digit" : "\(String(describing: selectedRightNumber))")
                        .foregroundStyle(.gray)
                        .textFieldUnderbarStyle(lineColor: .black)
                        .boldTextStyle()
                })
                .padding()
                .sheet(isPresented: $showRightPicker) {
                    PickerView(number: $selectedRightNumber)
                }
            }
            
                
            NavigationLink(value: "") {
                Text("Next")
                    .commomButtonStyle(textColor: Color.nextButtonText ,backgroundColor: Color.mainPurple)
            }
            .navigationDestination(for: String.self) {_ in 
                CalculateView(title: "Random Problems")
                // left, right
            }
                
           
            

        }
        .toolbarStyle(title: "Random", onAutoButton: false)
        
    }
}

struct PickerView: View {
    @Binding var number: Int
    let numberRange: [Int] = [1, 10, 100, 1000]
    
    var body: some View {
        VStack {
            Picker("Pick", selection: $number) {
                ForEach(numberRange, id: \.self) { idx in
                    Text("\(idx)")
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
