//
//  PokemonAppDexApp.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 12/1/25.
//

import SwiftUI

@main
struct PokemonAppDexApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonExploreAssembly.view(dto: PokemonExploreAssemblyDTO())
        }
    }
}
