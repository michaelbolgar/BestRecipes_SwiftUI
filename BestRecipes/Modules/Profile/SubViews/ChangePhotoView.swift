//
//  ChangePhotoView.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 24.08.2025.
//


import SwiftUI

struct ChangePhotoView: View {
    
    private let avatars: [String] = [
        "avatar1",
        "avatar9",
        "avatar2",
        "avatar7",
        "avatar3",
        "avatar8",
        "avatar4",
        "avatar5",
        "avatar6"
    ]
    
    @Binding var selectedAvatar: String
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(avatars, id: \.self) { avatar in
                        AvatarCell(avatar: avatar, isSelected: avatar == selectedAvatar)
                            .onTapGesture {
                                withAnimation {
                                    selectedAvatar = avatar
                                }
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct AvatarCell: View {
    let avatar: String
    let isSelected: Bool
    
    var body: some View {
        Image(avatar)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(
                width: isSelected ? 300 : 250,
                height: isSelected ? 300 : 250
            )
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.redPrimary20, lineWidth: isSelected ? 3 : 1))
            .shadow(radius: isSelected ? 8 : 0)
            .animation(.easeInOut, value: isSelected)
    }
}
