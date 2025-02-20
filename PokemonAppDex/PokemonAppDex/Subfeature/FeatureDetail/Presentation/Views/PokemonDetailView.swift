//
//  PokemonDetailView.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

import SwiftUI


struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel
    
    init(_ viewModel: PokemonDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if viewModel.pokemonDetail == nil {
                Text("Loading...")
            } else {
                PokemonCellView(name: viewModel.pokemonDetail?.pokemon.name ?? "",
                                imageURL: viewModel.pokemonDetail?.pokemon.imageURL ?? URL(string: ""),
                                id: viewModel.pokemonDetail?.pokemon.id ?? 0)
                .frame(maxWidth: 400, maxHeight: 400)
                .padding(.horizontal, 12)

            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
