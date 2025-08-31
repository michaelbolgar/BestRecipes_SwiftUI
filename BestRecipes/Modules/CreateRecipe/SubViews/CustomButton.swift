//
//  CustomButton.swift
//  BestRecipes
//
//  Created by DimaTru on 20.08.2025.
//

import SwiftUI

struct CustomButton: View {
    // MARK: - Properties
    var image = ""
    var title = ""
    var unitsOfMeasurement: String = ""
    
    @State private var label = "0"
    @State private var showPicker = false
    @Binding var selectedValue: String
    
    let pickerValues = Array(0...1000)
    @State private var tempValue: Int = 0
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(image)
                .frame(width: 36, height: 36)
            Text(title)
                .font(.custom(AppFont.bold, size: 16))
            Spacer()
            Text("\(label)")
                .font(.custom(AppFont.regular, size: 14))
                .foregroundStyle(.secondary)
            Button {
                if let intValue = Int(selectedValue.filter("0123456789".contains)) {
                    tempValue = intValue
                } else {
                    tempValue = 0
                }
                showPicker = true
            } label: {
                Image("Arrow-Right")
            }
            .sheet(isPresented: $showPicker) {
                VStack(spacing: 16) {
                    Picker("Enter value", selection: $tempValue) {
                        ForEach(pickerValues, id: \.self) { value in
                            Text("\(value) \(unitsOfMeasurement)")
                                .tag(value)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    
                    Button("Enter") {
                        label = "\(tempValue) \(unitsOfMeasurement)"
                        selectedValue = "\(tempValue) \(unitsOfMeasurement)"
                        showPicker = false
                    }
                }
                .presentationDetents([.height(280)])
                .presentationDragIndicator(.visible)
            }
            .presentationDetents([.height(280)])
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.neutral10)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    CustomButton(image: "Serves", title: "Serves", selectedValue: .constant("4"))
}
