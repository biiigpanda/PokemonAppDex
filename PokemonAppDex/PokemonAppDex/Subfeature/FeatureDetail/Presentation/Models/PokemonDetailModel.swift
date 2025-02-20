//
//  PokemonDetailModel.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

struct PokemonDetailModel {
    let pokemon: PokemonModel
    let height: Int
    let weight: Int
    
    init?(pokemonDetail: PokemonDetailEntity) {
        guard let pokemon = PokemonModel(pokemon: pokemonDetail.pokemon) else {
            return nil
        }
        
        self.pokemon = pokemon
        self.height = pokemonDetail.height
        self.weight = pokemonDetail.weight
    }
}
