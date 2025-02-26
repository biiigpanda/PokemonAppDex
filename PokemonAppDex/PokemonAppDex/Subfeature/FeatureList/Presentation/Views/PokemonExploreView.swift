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
    
    let gridElements = [GridItem(.flexible(minimum: 200, maximum: 280), spacing: 10),GridItem(.flexible(minimum: 200, maximum: 280), spacing: 10)]
    
    var body: some View {
        NavigationStack {
            if viewModel.state == .okey {
                VStack(spacing: 4.0) {
                    Text("Pokedex")
                        .font(.custom(Constants.IdentifierFont.fontKetchum, size: 50))
                    searchBar
                }
                .padding(.bottom, 6)
                list
            }
            // Para la demo dejar estas lineas comentadas
            //            .searchable(text: $viewModel.searchText, prompt: "Search by number or name")
            //            .toolbar {
            //                ToolbarItem(placement: .principal) {
            //                    Text("Pokedex")
            //                        .font(.custom("Ketchum", size: 50))
            //                }
            //            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .padding(.top, 8)
        .loaderBase(state: self.viewModel.state)
    }
    
    var searchBar: some View {
        HStack(spacing: 8) {
            if viewModel.searchText.isEmpty {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            TextField(Constants.Literals.searchMain, text: $viewModel.searchText)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 300)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, 12)
        .frame(height: 30)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 7)
                .stroke(Color.black, lineWidth: 2)
                .padding(.horizontal, 12)
        )
        .cornerRadius(8)
    }
    
    var list: some View {
        ScrollView {
            LazyVGrid(columns: gridElements, spacing: 20.0, content: {
                ForEach(viewModel.filteredPokemonList, id: \.self) { pokemon in
                    NavigationLink(destination: PokemonDetailAssembly.view(dto: PokemonDetailAssemblyDTO(idPokemon: pokemon.id, urlImage: pokemon.imageURL!))) {
                        PokemonCellView(name: pokemon.name, imageURL: pokemon.imageURL, id: pokemon.id)
                            .frame(maxWidth: 190, maxHeight: 200)
                            .foregroundStyle(.black)
                    }
                }
            })
            .padding(.horizontal, 12)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
}
