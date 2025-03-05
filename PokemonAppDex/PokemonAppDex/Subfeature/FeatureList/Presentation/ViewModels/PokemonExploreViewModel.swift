//
//  PokemonExploreViewModel.swift
//  PokeDex
//
//  Created by yamartin on 22/11/24.
//

import Foundation


class PokemonExploreViewModel: BaseViewModel, ObservableObject {
    
    var dto: PokemonExploreAssemblyDTO?
    
    init(dto: PokemonExploreAssemblyDTO?) {
        self.dto = dto
    }
    
    private let getPokemonListUseCase: GetPokemonListUseCase = GetPokemonListUseCase(pokeDexRepository: ExploreRepository.shared)
    let getPokemonDetailUseCase = GetPokemonDetailUseCase(repository: DetailRepository())

    @Published var pokemonList: [PokemonModel] = [PokemonModel]()
    @Published var pokemonsCell: [PokemonModel] = [PokemonModel]()
    @Published var showError = false
    @Published var searchText: String = ""

    public override func onAppear() {
        self.loadPokemonList()
    }
    
    @MainActor
    func loadPokemonList() {
        self.state = .loading
        Task {
            do {
                let pokemonEntityList = try await getPokemonListUseCase.execute(limit: Constants.pokeApiPokemonListlimit)
                pokemonList += pokemonEntityList.compactMap({ pokemon in PokemonModel(pokemon: pokemon) })
                await self.loadPokemonDetail()
                self.pokemonsCell = self.pokemonsCell.sorted(by: { $0.id < $1.id })
                self.state = .okey
            } catch let error{
                print("error\(error.localizedDescription)")
                self.state = .error
                showError = true
            }
        }
    }
    
    @MainActor
    private func loadPokemonDetail() async {
        
        do {
            try await withThrowingTaskGroup(of: (PokemonEntity?).self, body: { group in
                
                pokemonList.forEach { pokemon in
                    print("pokemon \(pokemon)")

                    if (pokemon.id != 0) {
                        group.addTask {
                            return ( try await self.getPokemonDetailUseCase.execute(id: pokemon.id))
                        }
                    }
                    
                }
                
                for try await (pokemon) in group {
                    if let pokem = pokemon {
                        guard let model = PokemonModel(pokemon: pokem) else {
                            return
                        }
                        print("model \(model)")

                        pokemonsCell.append(model)
                    }
                }
            })
            
        } catch let error  {
            print("error func detail \(error)")
            print("error func detail \(error.localizedDescription)")

            self.state = .error
            showError = true
        }
    }
    
    var filteredPokemonList: [PokemonModel] {
        guard !searchText.isEmpty else { return pokemonsCell }
        if isNumber(searchText) {
            return pokemonsCell.filter { pokemonId in
                pokemonId.id.description.lowercased().contains(searchText.lowercased())
            }
        } else {
            return pokemonsCell.filter { pokemonName in
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
