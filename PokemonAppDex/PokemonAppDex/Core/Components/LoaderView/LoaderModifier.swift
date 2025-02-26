//
//  LoaderModifier.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 25/2/25.
//

import Foundation

import SwiftUI

struct LoaderModifier: ViewModifier {
    var state: ViewModelState
    var loader: AnyView
    
    func body(content: Content) -> some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            content
            if state == ViewModelState.loading {
                loader
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(.white)
            } 
        })
    }
}
