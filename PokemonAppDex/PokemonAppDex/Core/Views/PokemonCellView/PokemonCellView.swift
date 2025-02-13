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
        HStack {
            AsyncImage(url: imageURL) { image in
                image
                    .image?
                    .resizable()
            }
            .scaledToFit()
            .frame(width: 100, height: 100)
            
            Text(name)
        }
    }
}
