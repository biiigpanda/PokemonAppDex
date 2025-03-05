//
//  PokemonEntity.swift
//  PokeDex
//
//  Created by yamartin on 22/11/24.
//

import Foundation

struct PokemonEntity {
    let id: Int
    let name: String
    var imageURL: String
    var stats: [PokemonStats] = []
    var types: [PokemonTypes] = []
    var species: Species? = nil
    
    init?(pokemonResponse: PokemonResponseModel) {
        guard let urlComponents = URLComponents(string: pokemonResponse.url),
              let idString = urlComponents.path.split(separator: "/").last,
              let id = Int(idString) else {
            return nil
        }
        
        self.id = id
        self.name = pokemonResponse.name
        self.imageURL = Constants.APIEndpoint.getPokemonImage(id: id).url?.absoluteString ?? ""
        self.stats = []
        self.types = []
    }
    
    init?(pokemonDetailResponse: PokemonDetailReponseModel) {
        self.id = pokemonDetailResponse.id
        self.name = pokemonDetailResponse.name
        self.imageURL = Constants.APIEndpoint.getPokemonImage(id: id).url?.absoluteString ?? ""
        self.stats = pokemonDetailResponse.stats
        self.types = pokemonDetailResponse.types
        self.species = pokemonDetailResponse.species
    }
}
