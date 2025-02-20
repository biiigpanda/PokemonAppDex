//
//  PokemonDetailView.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

import SwiftUI


struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel
    @State private var barWidth: CGFloat = 0
    
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
            VStack {
                // for each por cada valor en el stat
                HStack(spacing: 8, content: {
//                    ForEach(viewModel.getPokemonStats(), id: \.self) { pokemonStat in
                    Text(viewModel.pokemonDetail?.stats.first?.stat.name ?? "")
                        Text("\(viewModel.pokemonDetail?.stats.first?.baseStat ?? 0)")
                        atackBar
                            .padding(.horizontal, 13)
                            .padding(.top, 8)
                            .onAppear {
                                withAnimation(.easeOut(duration: 1.0)) {
                                    barWidth = 0.8
                                }
                            }
//                    }
                })
                .padding(.horizontal, 4)
            }
            .padding(.horizontal, 12)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    var atackBar: some View {
        Color.clear
            .frame(maxWidth: .infinity, maxHeight: 25)
            .overlay(GeometryReader { gp in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.orange)
                        .frame(width: barWidth * gp.size.width)
                        .border(.black)
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: (1 - barWidth) * gp.size.width)
                        .border(.black)
                }
            })
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}
