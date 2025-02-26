//
//  DetailRepositoryProtocol.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

import Foundation

protocol DetailRepositoryProtocol {
    func fetchPokemonDetail(id: Int) async throws -> PokemonEntity?
}
