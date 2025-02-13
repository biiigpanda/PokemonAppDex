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
            Text(name)
        }
        .background()
    }
}
