//
//  PokemonDetailViewModel.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 20/2/25.
//

import Foundation

@MainActor
class PokemonDetailViewModel: BaseViewModel, ObservableObject {
    
    var dto: PokemonDetailAssemblyDTO?
    
    init(dto: PokemonDetailAssemblyDTO?) {
        self.dto = dto
    }
    
    let getPokemonDetailUseCase = GetPokemonDetailUseCase(repository: DetailRepository())
    
    @Published var pokemonDetail: PokemonModel?
    
    override func onAppear() {
        self.loadDetail()
    }
    
    func getPokemonStats() -> [PokemonStats] {
        if let pokemonstats = self.pokemonDetail?.stats {
            return pokemonstats
        } else {
            return []
        }
    }
    
    func loadDetail() {
        
        guard let idPokemon = dto?.idPokemon else {
            return // Mostrar error
        }
        
        Task {
            do {
                guard let pokemonDetailEntity: PokemonEntity = try await getPokemonDetailUseCase.execute(id: idPokemon) else {
                    return
                }
                
                self.pokemonDetail = PokemonModel(pokemon: pokemonDetailEntity)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func getPokemonTypes() -> [PokemonTypeObject] {
        var arrayTypes: [PokemonTypeObject] = []
        for type in self.pokemonDetail?.types ?? [] {
            arrayTypes.append(getPokemonTypes(idType: type.type.name))
        }
        return arrayTypes
    }
    
    func getPokemonTypes(idType: String) -> PokemonTypeObject {
        var object = PokemonTypeObject()
        
        let idTypes: PokemonType = PokemonType(rawValue: idType) ?? .normal
        
        switch idTypes {
            case .normal:
                object.name = "Normal"
                object.imgName = "img_normal_type"
            case .fire:
                object.name = "Fire"
                object.imgName = "img_fire_type"
            case .water:
                object.name = "Water"
                object.imgName = "img_water_type"
            case .electric:
                object.name = "Electric"
                object.imgName = "img_electric_type"
            case .grass:
                object.name = "Grass"
                object.imgName = "img_grass_type"
            case .ice:
                object.name = "Ice"
                object.imgName = "img_ice_type"
            case .fighting:
                object.name = "Fight"
                object.imgName = "img_fight_type"
            case .poison:
                object.name = "Posion"
                object.imgName = "img_posion_type"
            case .ground:
                object.name = "Ground"
                object.imgName = "img_ground_type"
            case .bug:
                object.name = "Bug"
                object.imgName = "img_bug_type"
            case .dark:
                object.name = "Dark"
                object.imgName = "img_dark_type"
            case.dragon:
                object.name = "Dragon"
                object.imgName = "img_dragon_type"
            case .fairy:
                object.name = "Fairy"
                object.imgName = "img_fairy_type"
            case .flying:
                object.name = "Fly"
                object.imgName = "img_fly_type"
            case .ghost:
                object.name = "Ghost"
                object.imgName = "img_ghost_type"
            case .psychic:
                object.name = "Physic"
                object.imgName = "img_physic_type"
            case .rock:
                object.name = "Rock"
                object.imgName = "img_rock_type"
            case .steel:
                object.name = "Steel"
                object.imgName = "img_steel_type"
        }
        return object
    }
}

struct PokemonTypeObject: Codable, Hashable, Identifiable {
    var id: UUID = UUID()

    var name: String = ""
    var imgName: String = ""
}

enum PokemonType: String, CaseIterable {
    case normal
    case fire
    case water
    case electric
    case grass
    case ice
    case fighting
    case poison
    case ground
    case bug
    case dark
    case dragon
    case fairy
    case flying
    case ghost
    case psychic
    case rock
    case steel
}
