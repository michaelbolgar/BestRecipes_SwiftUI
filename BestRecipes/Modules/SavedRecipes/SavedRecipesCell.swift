//
//  SavedRecipesCell.swift
//  BestRecipes
//
//  Created by DimaTru on 12.08.2025.
//

import SwiftUI

struct SavedRecipesCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Image("mockImage")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 58, height: 27)
                        .opacity(0.4)
                        .padding(8)
                        .blur(radius: 5)
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.black)
                        Text("5,0")
                            .font(.system(size: 14).bold())
                            .foregroundStyle(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 41, height: 25)
                        .opacity(0.3)
                        .padding(8)
                        .blur(radius: 5)
                    Text("15:10")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                
                ZStack {
                    Color.white
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                        .padding(8)
                    Image(systemName: "bookmark")
                        .foregroundStyle(.red)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            .frame(height: 180)
            
            HStack {
                Text("How to make sharwama at home")
                    .font(.system(size: 16).bold())
            }
            .padding(.vertical, 12)
            
            HStack {
                Image("mockImage")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                Text("By Zeelicious Foods")
                    .foregroundStyle(.secondary)
                    .font(.system(size: 12))
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    SavedRecipesCell()
}
