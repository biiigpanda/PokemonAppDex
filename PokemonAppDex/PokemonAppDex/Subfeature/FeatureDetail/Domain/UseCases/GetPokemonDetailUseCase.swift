//
//  GetPokemonDetailUseCase.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

import Foundation

class GetPokemonDetailUseCase {
    let repository: DetailRepositoryProtocol
    
    init(repository: DetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> PokemonDetailEntity? {
        guard let pokemonDetail: PokemonDetailEntity = try await repository.fetchPokemonDetail(id: id) else {
            return nil
        }
        
        return pokemonDetail
    }
}
