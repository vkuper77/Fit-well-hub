//
//  FooterContent.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 15.02.24.
//

import SwiftUI

struct FooterContent: View {
    var body: some View {
        VStack {
            Text("Добро пожаловать")
                .font(.custom("MontserratAlternates-Bold", size: 24))
                .foregroundColor(.primaryBlack)
            Text("Какой-то приветственный\nтекст о приложении")
                .padding(.top, 20)
                .font(.custom("MontserratAlternates-Regular", size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(.primaryBlack)
            HStack(spacing: 65) {
                HStack(spacing: 12) {
                    VStack{
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.white)
                            .strokeBorder(Color.primaryOrange, lineWidth: 2)
                            .frame(width: 14, height: 14)
                    }
                    VStack{
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.white)
                            .strokeBorder(Color.primaryOrange, lineWidth: 2)
                            .frame(width: 14, height: 14)
                    }
                    VStack {
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color.primaryOrange)
                            .strokeBorder(Color.primaryOrange, lineWidth: 2)
                            .frame(width: 42, height: 14)
                    }
                }
                
                NavigationLink {
                    CreateTrainingProgramView()
                } label: {
                    PrimaryButton(title: "Начать", loading: false)
                }
                
            }.padding(.top, 51)
        }.padding(EdgeInsets(top: 64, leading: 16, bottom: 8, trailing: 16) )
    }
}
