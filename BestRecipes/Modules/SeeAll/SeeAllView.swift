//
//  SeeAllView.swift
//  BestRecipes
//
//  Created by Sergey Zakurakin on 8/11/25.
//

import SwiftUI

struct SeeAllView: View {
    var body: some View {
        
        
        VStack {
            TrendingCell(imageURL: nil, title: "", kitchenName: "How to make sharwama at home", rating: 5.0, time: "10:30", isFavorite: true)
        }
    }
}







#Preview {
    SeeAllView()
}



//struct TrendingCell: View {
//    var body: some View {
//        VStack(alignment: .leading) {
//            ZStack {
//                Image(.cocktail)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 180)
//                
//                VStack(alignment: .trailing) {
//                    HStack {
//                        // TO DO Change better background
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(Color(.glass))
//                                .frame(width: 58, height: 28)
//                            HStack {
//                                Image(.star)
//                                Text("4.6")
//                                    .foregroundStyle(.white)
//                            }
//                        }
//                        
//                        Spacer()
//                        
//                        ZStack {
//                            Circle()
//                                .fill(Color(.white))
//                                .frame(width: 32, height: 32)
//                            
//                            Button {
//                                // TO DO STATE....
//                            } label: {
//                                Image(.inactive)
//                            }
//                        }
//                    }
//                    
//                    Spacer()
//                    
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color(.glass))
//                            .frame(width: 41, height: 25)
//                        
//                        Text("10:30")
//                            .foregroundStyle(.white)
//                            .font(.system(size: 12))
//                    }
//                }
//                .padding(8)
//            }
//            .frame(height: 180)
//            .clipShape(RoundedRectangle(cornerRadius: 15))
//            
//            Text("How to make sharwama at home")
//            HStack {
//                Image(.avatarTest)
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                    .clipShape(Circle())
//                Text("By Zeelicious Foods")
//            }
//        }
//        .padding(.horizontal, 16)
//    }
//}
