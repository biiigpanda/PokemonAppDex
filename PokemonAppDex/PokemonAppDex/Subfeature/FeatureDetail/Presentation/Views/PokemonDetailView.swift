//
//  PokemonDetailView.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

import SwiftUI


struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel
    @State var barWidth: Double = 0.0
    
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
            VStack(spacing: 4) {
                ForEach(viewModel.getPokemonStats(), id: \.stat.name) { pokemonStat in
                    HStack() {
                        Text(pokemonStat.stat.name)
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.25)
                            .scenePadding()
                        Text("\(pokemonStat.baseStat)")
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.25)
                        BarView(value: Double(pokemonStat.baseStat) / 255.0)
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
                    }
                }
            }
            .background(Color(red: 100.0/255.0, green: 205.0/255.0, blue: 189.0/255.0, opacity: 0.5))
            .frame(maxWidth: 400, maxHeight: 400)
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    // he puesto un elemento independiente las barras para que se actualice correctamente la anchura de ellas
    
    struct BarView: View {
        let value: Double
        @State private var animatedWidth: Double = 0.0
        
        var body: some View {
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: 25)
                .overlay(GeometryReader { gp in
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: animatedWidth * gp.size.width)
                            .border(.black)
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: (1 - animatedWidth) * gp.size.width)
                            .border(.black)
                    }
                })
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .onAppear {
                    withAnimation(.easeOut(duration: 1.0)) {
                        animatedWidth = value
                    }
                }
        }
    }
}
