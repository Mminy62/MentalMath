//
//  ToolbarModifier.swift
//  MentalMath
//
//  Created by 이민영 on 9/2/24.
//

import Foundation
import SwiftUI

struct ToolbarStyle: ViewModifier {
    @ObservedObject var viewModel = CalculateViewModel.shared
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var title: String
    var onAutoButton: Bool
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonView()
                }
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .bold()
                        .font(.system(size: 20))
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.onAutoMode.toggle()
                    }, label: {
                        Text("Auto")
                            .bold()
                            .foregroundStyle(viewModel.onAutoMode ? Color.mainPurple : .white)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(viewModel.onAutoMode ? .white : Color.mainPurple)
                                    .frame(width: 60, height: 30)
                            )
                    })
                    .opacity(onAutoButton ? 1 : 0)
                    .padding(.trailing, 15)
                    
                        
                }
            }
    }
}

extension View {
    func toolbarStyle(title: String, onAutoButton: Bool) -> some View {
        self.modifier(ToolbarStyle(title: title, onAutoButton: onAutoButton))
    }
}

