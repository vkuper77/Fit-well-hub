//
//  GoalTrainingView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.01.24.
//

import SwiftUI

struct GoalTrainingView: View {
    @State private var modelData = ModelData()
    @Binding var currentGoal: CommonData?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Цель тренировок")
                .font(.custom("MontserratAlternates-SemiBold", size: 18))
                .foregroundColor(Color("black-primary"))
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(modelData.goalTraining, id: \.id) { level in
                Button {
                    currentGoal = level
                } label: {
                    ElementButton(selected: currentGoal?.id == level.id, title: level.title, text: level.text)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 16) )
    }
}

#Preview {
    GoalTrainingView(currentGoal: .constant(nil))
}
