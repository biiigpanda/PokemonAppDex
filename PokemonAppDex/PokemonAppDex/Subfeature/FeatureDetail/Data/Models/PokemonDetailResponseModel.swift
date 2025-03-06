//
//  PokemonDetailResponseModel.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

import Foundation

struct PokemonDetailReponseModel: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let stats: [PokemonStats]
    let types: [PokemonTypes]
    let species: Species
}

// MARK: Base Stats of Pokemon

struct PokemonStats: Codable, Hashable {
    static func == (lhs: PokemonStats, rhs: PokemonStats) -> Bool {
        return lhs.baseStat == rhs.baseStat
    }
    
    let baseStat: Int
    let stat: BaseCharacteristic
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

// MARK: Get Species for to obtain a description

struct PokemonSpecies: Codable {
    let forms: BaseCharacteristic
}

// MARK: Get types of Pokemon

struct PokemonTypes: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    static func == (lhs: PokemonTypes, rhs: PokemonTypes) -> Bool {
        return lhs.slot == rhs.slot
    }
    
    let slot: Int
    let type: BaseCharacteristic
    
    enum CodingKeys: String, CodingKey {
        case slot = "slot"
        case type
    }
}

struct BaseCharacteristic: Codable, Hashable  {
    let name: String
    let url: String
}

// MARK: - Species
struct Species: Codable, Hashable {
    let name: String
    let url: String
}


