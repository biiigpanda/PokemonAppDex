//
//  PokemonCellView.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 13/2/25.
//

import SwiftUI

struct PokemonCellView: View {
    let name: String
    var imageURL: URL?
    let id: Int
    
    var body: some View {
        VStack {
            ZStack{
                Image("img_pokeball")
                    .resizable()
                    .opacity(0.8)
                AsyncImage(url: imageURL) { image in
                    image
                        .image?
                        .resizable()
                }
                .scaledToFit()
            }
            HStack {
                Text(name.capitalized)
                    .font(.custom("Gameplay", size: 16))
                HStack {
                    Text("#\(id)")
                        .font(.custom("Gameplay", size: 16))
                }
                .frame(alignment: .trailing)
            }
            .padding(.bottom, 8)
        }
        .background(Color(red: 100.0/255.0, green: 205.0/255.0, blue: 189.0/255.0, opacity: 0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}
