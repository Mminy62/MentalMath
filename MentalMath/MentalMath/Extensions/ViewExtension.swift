//
//  ViewExtension.swift
//  MentalMath
//
//  Created by 이민영 on 8/29/24.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
