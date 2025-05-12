//  Level1View.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//

import SwiftUI

struct Level2View: View {
    var body: some View {
        GameView(level: 2)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    Level2View()
}
