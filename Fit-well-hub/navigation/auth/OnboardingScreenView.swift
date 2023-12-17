//
//  ContentView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 5.12.23.
//

import SwiftUI

struct OnboardingScreenView: View {
    var body: some View {
        NavigationStack {
            Label()
            Spacer()
            VStack {
                NavigationLink(destination: AuthorizationScreenView()) {
                    SecondaryButton(title: "Войти")
                }
                Spacer().frame(height: 16)
                NavigationLink(destination: RegistrationScreenView()) {
                    PrimaryButton(title: "Регистрация")
                }
                Spacer().frame(height: 16)
                Footer()
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 32, trailing: 16))
        }
    }
}

struct Label: View {
    var body: some View {
        Text("FWH")
            .font(.system(size: 32, weight: .semibold))
            .padding(.top, 118)
    }
}


struct Footer: View {
    var body: some View {
        VStack{
            Text("Регистрируясь, я принимаю")
                .multilineTextAlignment(.center)
                .font(.system(size: 12))
                .foregroundColor(Color("black-custom"))
            NavigationLink(destination: PrivacyPolicyScreenView()) {
                Text("Политику конфиденциальности")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12))
                    .foregroundColor(Color("black-custom"))
                    .underline()
            }
        }
    }
}

#Preview {
    OnboardingScreenView()
}
