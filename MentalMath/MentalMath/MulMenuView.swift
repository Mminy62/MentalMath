//
//  MulMenuView.swift
//  MentalMath
//
//  Created by 이민영 on 8/29/24.
//

import SwiftUI

struct MulMenuView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    MulTableView()
                } label: {
                    Text("Multiplication Table")
                }
                
                NavigationLink {
                    MulRandomView()
                } label: {
                    Text("Multiplication Table")
                }
            }
        }
    }
}

#Preview {
    MulMenuView()
}
