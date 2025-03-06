//
//  PokemonDetailAssembly.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

import SwiftUI

class PokemonDetailAssembly {
    @MainActor
    static func view(dto: PokemonDetailAssemblyDTO) -> some View {
        let viewModel = PokemonDetailViewModel(dto: dto)
        return PokemonDetailView(viewModel)
    }
}

struct PokemonDetailAssemblyDTO {
    var idPokemon: Int
    var urlImage: URL
}
