//
//  SearchBarView 2.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 19.08.2025.
//


import SwiftUI

struct SearchBarView: View {
    // MARK: - Properties
    @Binding var searchText: String
    
    var onTapSearch: (() -> Void)? = nil
    var onTapCancel: (() -> Void)? = nil
    
    @FocusState private var isFocused: Bool
    
    enum Drawing {
        static let placeholderText = "Search recipes"
        static let cancelText = "Cancel"
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            HStack(spacing: Offsets.x0) {
                Button {
                    onTapSearch?()
                } label: {
                    AppImages.search
                        .frame(width: Offsets.x5, height: Offsets.x5)
                        .foregroundStyle(.neutral90)
                        .padding(Offsets.x4)
                }
                
                TextField(Drawing.placeholderText, text: $searchText)
                    .focused($isFocused)
                    .onChange(of: isFocused) { newValue in
                        if newValue {
                            onTapSearch?()
                        }
                    }
            
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
                    title: Drawing.cancelText) {
                        withAnimation {
                            isFocused = false
                            searchText = ""
                            onTapCancel?()
                        }
                    }
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.easeOut(duration: 0.3), value: isFocused)
    }
}

#Preview {
    SearchBarView(
        searchText: .constant("search")
    )
}
