//
//  ExploreDataSource.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 12/1/25.
//

import Foundation

class ExploreDataSource {
    func fetchPokemons(limit: Int) async throws -> PokemonListResponseModel {
        guard let url: URL = Constants.APIEndpoint.getPokemonList(limit: limit).url else {
            throw URLError(.badURL)
        }
        
        return try await NetworkUtils.shared.fetch(from: url)
    }
}
