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
    
    let gridElements = [GridItem(),GridItem()]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridElements, content: {
                    ForEach(viewModel.filteredPokemonList, id: \.self) { pokemon in
                        NavigationLink(destination: PokemonDetailAssembly.view(dto: PokemonDetailAssemblyDTO(idPokemon: pokemon.id, urlImage: pokemon.imageURL!))) {
                            PokemonCellView(name: pokemon.name, imageURL: pokemon.imageURL, id: pokemon.id)
                                .frame(maxWidth: 300, maxHeight: 220)
                                .foregroundStyle(.black)
                        }
                    }
                })
                .padding(.horizontal,12)
            }
            .searchable(text: $viewModel.searchText, prompt: "Search by number or name")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Pokedex")
                        .font(.custom("Ketchum", size: 50))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.onAppear()
        }
        .padding(.top, 8)
    }
}
