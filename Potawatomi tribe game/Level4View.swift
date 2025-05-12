//
//  Level1View.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//

import SwiftUI

struct Level4View: View {
    var body: some View {
        GameView(level: 4)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    Level4View()
}
