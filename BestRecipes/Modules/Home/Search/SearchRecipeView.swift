//
//  SearchRecipeViewWithSuggestions.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//

import SwiftUI

struct SearchRecipeViewWithSuggestions: View {
    // MARK: - Properties
    @Binding var searchText: String
    var suggestions: [String]
    var onSelectSuggestion: (String) -> Void
    
    var onTapSearch: (() -> Void)? = nil
    var onTapCancel: (() -> Void)? = nil
    
    @FocusState private var isFocused: Bool
    
    enum Drawing {
        static let placeholderText = "Search recipes"
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            HStack(spacing: Offsets.x0) {
                AppImages.search
                    .frame(width: Offsets.x5, height: Offsets.x5)
                    .foregroundStyle(.neutral90)
                    .padding(Offsets.x4)
                
                TextField(Drawing.placeholderText, text: $searchText)
                
                if !searchText.isEmpty {
                    Button {
                        withAnimation {
                            searchText = ""
                        }
                    } label: {
                        AppImages.xmark
                            .foregroundStyle(.neutral20)
                            .padding(Offsets.x4)
                    }
                }
            }
            .background(Color.appBackground)
            .overlay {
                RoundedRectangle(cornerRadius: Offsets.x3)
                    .stroke(.neutral30, lineWidth: 1)
            }
            if isFocused {
                MiniRedButton(
                    title: "Cancel") {
                        withAnimation {
                            isFocused = false
                            searchText = ""
                            onTapCancel?()
                        }
                    }
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .focused($isFocused)
        .onChange(of: isFocused) { newValue in
            if newValue {
                onTapSearch?()
            }
        }
        .animation(.easeOut(duration: 0.3), value: isFocused)
    }
}

#Preview {
    SearchRecipeViewWithSuggestions(searchText: .constant("search"))
}
