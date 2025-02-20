//
//  PokemonExploreViewModel.swift
//  PokeDex
//
//  Created by yamartin on 22/11/24.
//

import Foundation


class PokemonExploreViewModel: BaseViewModel,ObservableObject {
    
    var dto: PokemonExploreAssemblyDTO?
    
    init(dto: PokemonExploreAssemblyDTO?) {
        self.dto = dto
    }
    
    private let getPokemonListUseCase: GetPokemonListUseCase = GetPokemonListUseCase(pokeDexRepository: ExploreRepository.shared)
    
    @Published var pokemonList: [PokemonModel] = [PokemonModel]()
    @Published var showError = false
    @Published var searchText: String = ""

    public override func onAppear() {
        self.loadPokemonList()
    }
    
    @MainActor
    func loadPokemonList() {
        print("loadPokemonList")
        self.state = .loading
        Task {
            do {
                let pokemonEntityList = try await getPokemonListUseCase.execute(limit: Constants.pokeApiPokemonListlimit)
                pokemonList += pokemonEntityList.compactMap({ pokemon in PokemonModel(pokemon: pokemon) })
                self.state = .okey
            } catch {
                self.state = .error
                showError = true
            }
        }
    }
    
    var filteredPokemonList: [PokemonModel] {
        guard !searchText.isEmpty else { return pokemonList }
        if isNumber(searchText) {
            return pokemonList.filter { pokemonId in
                pokemonId.id.description.lowercased().contains(searchText.lowercased())
            }
        } else {
            return pokemonList.filter { pokemonName in
                pokemonName.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func isNumber(_ text: String) -> Bool {
        return Double(text) != nil
    }
    
   /* func modalActionPerfomed(action: ModalAction) {
            switch action {
            case .retry:
                break
            case .exit:
                break
            }
        }*/
    
}
