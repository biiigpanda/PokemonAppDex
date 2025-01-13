//
//  SplashView.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 12/1/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            PokemonExploreAssembly.view(dto: PokemonExploreAssemblyDTO())
        } else {
            VStack {
                Image("main_logo")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}


#Preview {
    SplashView()
}
