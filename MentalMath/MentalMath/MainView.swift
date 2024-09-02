//
//  MainView.swift
//  MentalMath
//
//  Created by 이민영 on 9/2/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: .logo)
            
            HStack {
                NavigationLink {
                    MulMenuView()
                } label: {
                    Text("×")
                        .fontWeight(.heavy)
                        .font(.system(size: 70))
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 10.0)
                                
                        }
                }

            }
        }
    }
}

#Preview {
    MainView()
}
