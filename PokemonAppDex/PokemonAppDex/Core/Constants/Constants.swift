//
//  Constants.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 12/1/25.
//

import Foundation

struct Constants {
    static let pokeApiURL: String = "https://pokeapi.co/api/v2/"
    static let pokeApiArtworkURL: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%d.png"
    static let pokeApiTimeoutInterval: Double = 15.0
    
    static let pokeApiPokemonListlimit: Int = 1025
    
    enum APIEndpoint {
        case getPokemonList(limit: Int)
        case getPokemonImage(id: Int)
        case getPokemonDetails(id: Int)
        //     case getPokemonElements(id: Int)
        var url: URL? {
            switch self {
                case .getPokemonList(let limit):
                    return URL(string: "\(pokeApiURL)pokemon?limit=\(limit)")
                case .getPokemonImage(let id):
                    return URL(string: String(format: pokeApiArtworkURL, id))
                case .getPokemonDetails(let id):
                    return URL(string: "\(pokeApiURL)pokemon/\(id)/")
                    //            case .getPokemonElements(let id):
                    //     return URL(string: "\(pokeApiURL)pokemon/\(id)/")
            }
        }
    }
    
    enum IdentifierImg {
        static let mainLogo = "main_logo"
    }
    
    enum Literals {
        static let searchMain = String(localized: "Search by number or name")
        static let stats = String(localized: "Stats")
        static let loading = String(localized: "Loading...")
    }
    
    enum IdentifierFont {
        static let fontGamePlay = "GamePlay"
        static let fontKetchum = "Ketchum"
    }
}

extension String {
    func formattedStatName() -> String {
        let mapping: [String: String] = [
            "hp": "HP",
            "attack": "Attack",
            "defense": "Defense",
            "special-attack": "S.Attack",
            "special-defense": "S.Defense",
            "speed": "Speed"
        ]
        
        return mapping[self] ?? self.replacingOccurrences(of: "_", with: " ").capitalized
    }
}
