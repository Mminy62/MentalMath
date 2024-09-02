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
                    Toggle(isOn: $viewModel.onAutoMode, label: {
                        Text("Auto")
                            .bold()
                    })
                    .padding(.trailing, 15)
                    .foregroundStyle(Color.mainPurple)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .opacity(onAutoButton ? 1 : 0)
                }
            }
    }
}

extension View {
    func toolbarStyle(title: String, onAutoButton: Bool) -> some View {
        self.modifier(ToolbarStyle(title: title, onAutoButton: onAutoButton))
    }
}

