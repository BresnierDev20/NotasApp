//
//  CustomModifiers.swift
//  Notas
//
//  Created by Bresnier Moreno on 29/11/24.
//

import SwiftUI

struct EstiloTexto: ViewModifier {
    var font: Font
    var fontWeight: Font.Weight
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
            .foregroundColor(color)
            .padding()
    }
}

extension View {
    func estiloTexto(font: Font, color: Color, fontWeight: Font.Weight ) -> some View {
        self.modifier(EstiloTexto(font: font, fontWeight: fontWeight, color: color))
    }
}
