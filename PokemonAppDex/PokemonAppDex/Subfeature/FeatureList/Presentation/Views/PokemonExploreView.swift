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
                VStack(spacing: 8.0) {
                    title
                    searchBar
                }
                .padding(.bottom, 6)
                if viewModel.filteredPokemonList.isEmpty {
                    //cambiar nombre de view a emptyView
                    errorView
                } else {
                    list
                }
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
        .ignoresSafeArea(.container, edges: .top)
    }
    
    var title: some View {
        HStack {
            imgPokeball
            Text(Constants.Literals.pokedex)
                .font(.custom(Constants.IdentifierFont.fontKetchum, size: 50))
                .foregroundStyle(.white)
            imgPokeball
        }
        .frame(maxWidth: .infinity)
        .background(.red)
    }
    
    var imgPokeball: some View {
        Image(Constants.IdentifierImg.pokeballImg)
            .resizable()
            .frame(width: 80.0, height: 80.0)
    }
    
    var searchBar: some View {
        HStack(spacing: 8) {
            if viewModel.searchText.isEmpty {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            TextField(Constants.Literals.searchMain,
                      text: $viewModel.searchText)
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
                        PokemonCellView(name: pokemon.name,
                                        imageURL: pokemon.imageURL,
                                        id: pokemon.id)
                        .frame(maxWidth: 190, maxHeight: 200)
                        .foregroundStyle(.black)
                    }
                }
            })
            .padding(.horizontal, 12)
        }
        .simultaneousGesture(
            DragGesture().onChanged { _ in
                hideKeyboard()
            }
        )
        .navigationBarTitleDisplayMode(.large)
    }
    
    var errorView: some View {
        VStack(alignment: .center) {
            Image(Constants.IdentifierImg.warnningSearch)
                .resizable()
                .frame(width: 180.0, height: 180.0)
            Text(Constants.Literals.notDataFound)
                .font(.custom(Constants.IdentifierFont.fontGamePlay, size: 18))
                .multilineTextAlignment(.center)
                .lineSpacing(5.0)
            Spacer()
        }
        .padding(.horizontal, 12)
    }
}
