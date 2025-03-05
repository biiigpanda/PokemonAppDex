//
//  DetailDataSource.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

import Foundation

class DetailDataSource {
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetailReponseModel {
        guard let url: URL = Constants.APIEndpoint.getPokemonDetails(id: id).url else {
            throw URLError(.badURL)
        }
        var pokemon: PokemonDetailReponseModel = try await NetworkUtils.shared.fetch(from: url)
        print(pokemon)
        return try await NetworkUtils.shared.fetch(from: url)
    }
}
