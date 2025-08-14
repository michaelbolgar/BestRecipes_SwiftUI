//
//  CustomCheckbox.swift
//  BestRecipes
//
//  Created by KOZLOVA Anastasia on 14.08.2025.
//

import SwiftUI

struct CustomCheckbox: View {
  @Binding var isChecked: Bool
  
  var body: some View {
    ZStack {
      Circle()
        .stroke(isChecked ? .green : .black, lineWidth: 2)
        .background(Circle().fill(isChecked ? Color.green : Color.black))
        .frame(width: 24, height: 24)
      
      Image(systemName: "checkmark")
        .foregroundColor(.white)
        .font(.system(size: 14, weight: .bold))
    }
    .onTapGesture {
      isChecked.toggle()
    }
  }
}
