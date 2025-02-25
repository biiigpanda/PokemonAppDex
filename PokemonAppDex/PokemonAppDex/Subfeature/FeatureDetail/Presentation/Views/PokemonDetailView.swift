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
    
    let arrayColors: [Color] = [.green, .red, .blue, .purple, .pink, .yellow]

    
    init(_ viewModel: PokemonDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if viewModel.pokemonDetail == nil {
                Text(Constants.Literals.loading)
            } else {
                PokemonCellView(name: viewModel.pokemonDetail?.pokemon.name ?? "",
                                imageURL: viewModel.pokemonDetail?.pokemon.imageURL ?? URL(string: ""),
                                id: viewModel.pokemonDetail?.pokemon.id ?? 0)
                .frame(maxWidth: 300, maxHeight: 310)
                .padding(.horizontal, 12)
                
            }
            VStack {
                Text(Constants.Literals.stats)
                    .font(.custom(Constants.IdentifierFont.fontGamePlay, size: 20))
                    .padding(.top, 8)
                ForEach(Array(viewModel.getPokemonStats().enumerated()), id: \.element.stat.name) { index, pokemonStat in
                    HStack() {
                        Text(pokemonStat.stat.name.formattedStatName())
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.3)
                            .font(.custom(Constants.IdentifierFont.fontKetchum, size: 21))
                        Text("\(pokemonStat.baseStat)")
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.2)
                            .font(.custom(Constants.IdentifierFont.fontGamePlay, size: 18))

                        BarView(value: Double(pokemonStat.baseStat) / 255.0,
                                barColor: arrayColors[index % arrayColors.count])
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
                    }
                    .padding(.horizontal, 8)
                    .scenePadding()

                }
            }
            .background(Color(red: 208.0/255.0, green: 205.0/255.0, blue: 189.0/255.0, opacity: 0.5))
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            .frame(maxWidth: 350, maxHeight: .infinity)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    // he puesto un elemento independiente las barras para que se actualice correctamente la anchura de ellas
    struct BarView: View {
        let value: Double
        let barColor: Color
        @State private var animatedWidth: Double = 0.0
        
        var body: some View {
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: 20)
                .overlay(GeometryReader { gp in
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(barColor)
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
