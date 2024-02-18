//
//  LevelTrainingView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.01.24.
//

import SwiftUI

struct LevelTrainingView: View {
    @Binding var currentLevel: CommonData?
    let trainingLevels: [CommonData]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Уровень подготовки")
                .font(.custom("MontserratAlternates-SemiBold", size: 18))
                .foregroundColor(.primaryBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(trainingLevels, id: \.id) { level in
                Button {
                    currentLevel = level
                } label: {
                    ElementButton(selected: currentLevel?.id == level.id, title: level.title, text: level.text)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 16) )
    }
}

//#Preview {
//    LevelTrainingView(currentLevel: .constant(nil), trainingLevels: .constant())
//}
