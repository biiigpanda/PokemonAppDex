//
//  LoaderView.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 25/2/25.
//

//
//  LoaderView.swift
//  PokeDex
//
//  Created by yamartin on 12/12/24.
//

import Foundation
import SwiftUI

struct LoaderView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                VStack(alignment: .center, spacing: 0.0) {
                    Spacer()
                    Image("img_pokeball")
                        .resizable()
                        .frame(width: 300, height: 300)
                    HStack(spacing: 12.0) {
                        Text(Constants.Literals.loading)
                            .font(.custom(Constants.IdentifierFont.fontGamePlay, size: 28))
                            .foregroundStyle(.white)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(2.0)
                    }
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}

extension View {
    func loaderBase(state: ViewModelState) -> some View {
        self.modifier(LoaderModifier(state: state, loader: AnyView(LoaderView())))
    }
}
