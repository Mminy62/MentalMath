//
//  BackButtonView.swift
//  MentalMath
//
//  Created by 이민영 on 8/30/24.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body : some View {
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
}

#Preview {
    BackButtonView()
}