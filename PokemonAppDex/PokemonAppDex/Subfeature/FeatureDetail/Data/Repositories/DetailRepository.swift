//
//  DetailRepositoryProtocol.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

import Foundation

class DetailRepository: DetailRepositoryProtocol {
    static let shared = DetailRepository()
    
    private let detailDataSource = DetailDataSource()
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonEntity? {
        let pokemonDetailResponse: PokemonDetailReponseModel = try await detailDataSource.fetchPokemonDetail(id: id)
        
        print(pokemonDetailResponse)
        
        guard let pokemonDetail: PokemonEntity = PokemonEntity(pokemonDetailResponse: pokemonDetailResponse) else {
            return nil
        }
        
        return pokemonDetail
    }
}
