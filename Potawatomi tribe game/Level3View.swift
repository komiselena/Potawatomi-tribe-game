//  Level1View.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//

import SwiftUI

struct Level3View: View {
    var body: some View {
        GameView(level: 3)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    Level3View()
}
