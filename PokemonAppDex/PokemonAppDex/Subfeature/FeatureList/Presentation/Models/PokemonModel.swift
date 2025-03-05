//
//  PokemonModel.swift
//  PokeDex
//
//  Created by yamartin on 22/11/24.
//

import Foundation

struct PokemonModel: Hashable {
    static func == (lhs: PokemonModel, rhs: PokemonModel) -> Bool {
        return lhs.id == rhs.id

    }
    
        
    let id: Int
    let name: String
    var imageURL: URL?
    var stats: [PokemonStats]
    var types: [PokemonTypes]
    var species: Species
    
    init?(pokemon: PokemonEntity) {
        self.id = pokemon.id
        self.name = pokemon.name
        self.imageURL = URL(string: pokemon.imageURL)
        self.stats = pokemon.stats
        self.types = pokemon.types
        self.species = pokemon.species ?? Species(name: "", url: "")
    }
}
