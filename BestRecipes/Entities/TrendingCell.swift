//
//  TrendingCell.swift
//  BestRecipes
//
//  Created by Sergey Zakurakin on 8/11/25.
//

import SwiftUI

struct TrendingCell: View {
    
    let imageURL: URL?
    let title: String
    let kitchenImageURL: URL? = nil
    let kitchenName: String
    let rating: Double
    let time: String
    @State var isFavorite: Bool = false
    // TO DOO BUTTON
//    var favoriteAction: (() -> Void)?
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.2)
                            .overlay(
                                ProgressView()
                            )
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure(_):
                        Image(.testPicture)
                            .resizable()
                            .scaledToFill()
                    default:
                        Image(.testPicture)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(height: 180)
                .clipped()
                
                VStack(alignment: .trailing) {
                    HStack {
                        // TO DO Change better background
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.glass))
                                .frame(width: 58, height: 28)
                            HStack {
                                Image(.star)
                                Text("\(rating.formatted())")
                                    .foregroundStyle(.white)
                            }
                        }
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(Color(.white))
                                .frame(width: 32, height: 32)
                            
                            Button {
                                isFavorite.toggle()
//                                favoriteAction()
                            } label: {
                                Image(isFavorite ? .active : .inactive)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.glass))
                            .frame(width: 41, height: 25)
                        
                        Text(time)
                            .foregroundStyle(.white)
                            .font(.system(size: 12))
                    }
                }
                .padding(8)
            }
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Text(title)
            HStack {
                AsyncImage(url: kitchenImageURL) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.3)
                            .overlay(
                                Image(.avatarTest)
                                .resizable()
                                .scaledToFill()
                            )
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure(_):
                        Image(.avatarTest)
                            .resizable()
                            .scaledToFill()
                    default:
                        Image(.avatarTest)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                
                Text(kitchenName)
            }
        }
        .padding(.horizontal, 16)
    }
}


#Preview {
    TrendingCell(
        imageURL: URL(string: "https://image"),
        title: "How to make shawarma at home",
        kitchenName: "Zeelicious Foods",
        rating: 4.6,
        time: "10:30"
//        isFavorite: true
    )
}
