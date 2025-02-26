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
            }
            HStack {
                Text(name.capitalized)
                    .font(.custom(Constants.IdentifierFont.fontGamePlay, size: 16))
                HStack {
                    Text(String(format: "#%03d", id))
                        .font(.custom(Constants.IdentifierFont.fontGamePlay, size: 16))
                }
                .frame(alignment: .trailing)
            }
            .padding(.bottom, 8)
        }
        .background(Colors.colorGreenCell)
        .cornerRadius(15)
        .shadow(color: .black, radius: 5, x: 0, y: 5)
    }
}
