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
        ScrollView {
            VStack {
                if viewModel.pokemonDetail == nil {
                    Text(Constants.Literals.loading)
                } else {
                    PokemonCellView(name: viewModel.pokemonDetail?.name ?? "",
                                    imageURL: viewModel.pokemonDetail?.imageURL ?? URL(string: ""),
                                    id: viewModel.pokemonDetail?.id ?? 0)
                    .frame(maxWidth: 300, maxHeight: 310)
                    .padding(.horizontal, 12)
                }
                typesView
                    .padding(.top, 16)
                statsView
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
        .scrollIndicators(.hidden)
    }
    
    var typesView: some View {
        VStack(spacing: 20) {
            ForEach(viewModel.getPokemonTypes(), id: \.self) { type in
                HStack {
                    Image(type.imgName)
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text("\(type.name)")
                        .font(.custom(Constants.IdentifierFont.fontGamePlay, size: 20))
                        .padding(.trailing, 8)
                }
                .background(LinearGradient(gradient: Gradient(colors: [Colors.colorOrangeUp,
                                                                       Colors.colorOrangeMid,
                                                                       Colors.colorOrangeDown,]),
                                           startPoint: .topTrailing, endPoint: .bottomLeading))
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .shadow(color: .black, radius: 5, x: 0, y: 5)
            }
        }
        .frame(width: 300)

        .padding(.bottom, 16)
    }
    
    var statsView: some View {
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
        .background(Colors.colorOrangeStats)
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        .frame(maxWidth: 350, maxHeight: .infinity)
    }
    // MARK: Barview
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
