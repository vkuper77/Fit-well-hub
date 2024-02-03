//
//  ContentView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 5.12.23.
//

import SwiftUI


struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            MaskScreenView(topComponent: Spacer(), bottomComponent: Footer())
        }
    }
}

struct Footer: View {
    var body: some View {
        VStack {
            Text("Добро пожаловать")
                .font(.custom("MontserratAlternates-Bold", size: 24))
                .foregroundColor(Color("black-primary"))
            Text("Какой-то приветственный\nтекст о приложении")
                .padding(.top, 20)
                .font(.custom("MontserratAlternates-Regular", size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(Color("black-primary"))
            HStack(spacing: 65) {
                HStack(spacing: 12) {
                    VStack{
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.white)
                            .strokeBorder(Color("orange-primary"), lineWidth: 2)
                            .frame(width: 14, height: 14)
                    }
                    VStack{
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.white)
                            .strokeBorder(Color("orange-primary"), lineWidth: 2)
                            .frame(width: 14, height: 14)
                    }
                    VStack {
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color("orange-primary"))
                            .strokeBorder(Color("orange-primary"), lineWidth: 2)
                            .frame(width: 42, height: 14)
                    }
                }
                
                NavigationLink {
                    CreateTrainingProgramView()
                } label: {
                    PrimaryButton(title: "Начать")
                }
                
            }.padding(.top, 51)
        }.padding(EdgeInsets(top: 64, leading: 16, bottom: 8, trailing: 16) )
    }
}


#Preview {
    OnboardingView()
}
