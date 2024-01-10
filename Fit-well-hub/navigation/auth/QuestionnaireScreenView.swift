//
//  QuestionnaireScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 8.01.24.
//

import SwiftUI

struct QuestionnaireScreenView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLinkActiveRegistrationScreen: Bool = false
    
    @State var indexAnim: Double = 1.0
    @State var index: Int = 1
    
    @State var levelTraining: CommonData?
    @State var goalTraining: CommonData?
    @State var durationTraining: CommonData?
    @State var daysTraining: [String] = []
    
    var body: some View {
        ScrollView {
            VStack {
                ProgressView(value: indexAnim, total: 3) {
                    Text("Шаг \(Int(index))/3")
                        .font(.custom("MontserratAlternates-Regular", size: 16))
                        .foregroundColor(Color("black-primary"))
                }
                .tint(Color("orange-secondary"))
            }
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
            
            switch(index) {
                case 1: 
                    LevelTrainingView(currentLevel: $levelTraining)
                case 2: 
                    GoalTrainingView(currentGoal: $goalTraining)
                case 3: 
                    DurationTrainingView(currentDuration: $durationTraining, currentDays: $daysTraining)
                default:
                    Text("")
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton(action: {
                    if index == 1 {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    withAnimation(.linear(duration: 5.0)) {
                        indexAnim -= 1
                    }
            
                    index -= 1
                    
                }, colorPrimary: Color("orange-secondary"), colorSecondary: .white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if index == 3 {
                        isLinkActiveRegistrationScreen = true
                        return
                    }
                    
                    withAnimation(.linear(duration: 5.0)) {
                        indexAnim += 1
                    }
                    
                    index += 1
                } label: {
                    Text("Далее")
                        .font(.custom("MontserratAlternates-SemiBold", size: 16))
                        .foregroundColor(Color("orange-secondary"))
                }
            }
        }
        
        NavigationLink(destination: RegistrationScreenView(), isActive: $isLinkActiveRegistrationScreen) {
            EmptyView()
        }
    }
}

#Preview {
    QuestionnaireScreenView()
}
