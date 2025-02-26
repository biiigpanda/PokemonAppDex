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
                AsyncImage(url: imageURL) { image in
                    image
                        .image?
                        .resizable()
                }
            }
            HStack {
                Text(name.capitalized)
                    .font(.custom(Constants.IdentifierFont.fontGamePlay, size: 16))
                Text(String(format: "#%03d", id))
                    .font(.custom(Constants.IdentifierFont.fontGamePlay, size: 16))
            }
            .padding(.bottom, 10)
            .shadow(color: .white, radius: 5, x: 0, y: 5)
        }
        //        .background(Colors.colorGreenCell)
        .background(LinearGradient(gradient: Gradient(colors: [Colors.colorGreenCell,
                                                               Colors.colorGreenMid,
                                                               Colors.colorGreenDown,]),
                                   startPoint: .bottom, endPoint: .top))
        
        .cornerRadius(15)
        .shadow(color: .black, radius: 5, x: 0, y: 5)
    }
}
