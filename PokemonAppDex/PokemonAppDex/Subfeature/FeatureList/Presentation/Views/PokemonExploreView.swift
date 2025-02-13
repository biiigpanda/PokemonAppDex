//
//  PokemonExploreView.swift
//  PokeDex
//
//  Created by yamartin on 22/11/24.
//

import SwiftUI

struct PokemonExploreView: View {
    
    @StateObject private var viewModel: PokemonExploreViewModel
    
    init(_ viewModel: PokemonExploreViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    let gridElements = [GridItem(.flexible(minimum:50)),GridItem(.flexible(minimum:50))]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridElements, content: {
                    ForEach(viewModel.pokemonList, id: \.self) { pokemon in
                        //                    NavigationLink(destination: PokemonDetailAssembly.view(dto: PokemonDetailAssemblyDTO(idPokemon: pokemon.id))) {
                        PokemonCellView(name: pokemon.name, imageURL: pokemon.imageURL)
                        //                    }
                    }
                })
            }
            .navigationTitle("Pokedex Kanto")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
