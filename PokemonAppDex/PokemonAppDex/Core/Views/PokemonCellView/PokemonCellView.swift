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
                    .frame(maxWidth: 170, maxHeight: 170)
                    .opacity(0.5)
                AsyncImage(url: imageURL) { image in
                    image
                        .image?
                        .resizable()
                }
                .scaledToFit()
                .frame(width: 140, height: 140)
            }
            HStack {
                Text(name.capitalized)
                    .font(.custom("Gameplay", size: 18))
                HStack {
                    Text("#\(id)")
                        .font(.custom("Gameplay", size: 18))
                }
                .frame(alignment: .trailing)
            }
        }
        .background()
    }
}
