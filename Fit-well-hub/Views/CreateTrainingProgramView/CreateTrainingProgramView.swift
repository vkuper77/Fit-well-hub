//
//  QuestionnaireScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 8.01.24.
//

import SwiftUI

struct CreateTrainingProgramView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = CreateTrainingProgramViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ProgressView(value: viewModel.indexAnim, total: 3) {
                    Text("Шаг \(Int(viewModel.index))/3")
                        .font(.custom("MontserratAlternates-Regular", size: 16))
                        .foregroundColor(.primaryBlack)
                }
                .tint(.secondaryOrange)
            }
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
            
            switch(viewModel.index) {
                case 1:
                LevelTrainingView(currentLevel: $viewModel.level, trainingLevels: viewModel.levelsTraining)
                case 2:
                GoalTrainingView(currentGoal: $viewModel.goal, goalTraining: viewModel.goalsTraining)
                case 3:
                DurationTrainingView(
                    currentDuration: $viewModel.duration,
                    currentDays: $viewModel.daysTraining,
                    weekdaysAbbreviated: viewModel.weekdaysAbbreviated,
                    durationTraining: viewModel.durationTraining
                )
                default:
                    Text("")
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton(action: {
                    if viewModel.index == 1 {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    withAnimation(.linear(duration: 5.0)) {
                        viewModel.indexAnim -= 1
                    }
            
                    viewModel.index -= 1
                    
                }, colorPrimary: Color("orange-secondary"), colorSecondary: .white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if viewModel.index == 3 {
                        viewModel.isLinkActiveRegistrationScreen = true
                        return
                    }
                    
                    withAnimation(.linear(duration: 5.0)) {
                        viewModel.indexAnim += 1
                    }
                    
                    viewModel.index += 1
                } label: {
                    Text("Далее")
                        .font(.custom("MontserratAlternates-SemiBold", size: 16))
                        .foregroundColor(.secondaryOrange)
                }
            }
        }
        
        NavigationLink(destination: RegistrationView(), isActive: $viewModel.isLinkActiveRegistrationScreen) {
            EmptyView()
        }
    }
}

#Preview {
    CreateTrainingProgramView()
}
