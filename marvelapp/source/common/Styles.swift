//
//  Styles.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 24/11/2020.
//

import Foundation
import SwiftUI

/// Standar App image style
struct ImagenStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .background(Color.gray)
            .clipShape(Rectangle())
            .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
            .shadow(radius: 10.0)
    }
}
