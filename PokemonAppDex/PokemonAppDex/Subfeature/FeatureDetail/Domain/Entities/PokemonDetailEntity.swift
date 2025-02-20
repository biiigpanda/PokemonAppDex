//
//  PokemonDetailEntity.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

import Foundation

struct PokemonDetailEntity {
    let pokemon: PokemonEntity
    let height: Int
    let weight: Int
    
    init?(pokemonDetailResponse: PokemonDetailReponseModel) {
        guard let pokemon = PokemonEntity(pokemonDetailResponse: pokemonDetailResponse) else {
            return nil
        }
        
        self.pokemon = pokemon
        self.height = pokemonDetailResponse.height
        self.weight = pokemonDetailResponse.weight
    }
}
