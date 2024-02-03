//
//  PasswordRecoveryScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct PasswordRecoveryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var email: String = ""
    @State var isErrorEmail: Bool = false
    @State var isLinkActive: Bool = false
    
    var isButtonEnabled: Bool {
        return !email.isEmpty && !isErrorEmail
    }
    
    func submit () {
        if !isValidEmail(email) {
            isErrorEmail = true
            isLinkActive = false
        } else {
            isErrorEmail = false
            isLinkActive = true
        }
    }
    
    var body: some View {
        NavigationStack {
            MaskScreenView(topComponent: VStack {
                Spacer().frame(height: 40)
                Text("Восстановление пароля")
                    .font(.custom("MontserratAlternates-Bold", size: 24))
                    .foregroundColor(.white)
                Spacer().frame(height: 16)
                Text("Введите ваш email для получения\nкода на восстановление пароля")
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 34)
            }, bottomComponent: VStack {
                Spacer().frame(height: 62)
                MainInput(value: $email, placeholder: "Email", label: "Email")
                    .onChange(of: email) { isErrorEmail = false}
                
                if isErrorEmail {
                    Spacer().frame(height: 4)
                    HStack {
                        Text("Неправильный формат электронной почты.")
                            .multilineTextAlignment(.leading)
                            .font(.custom("MontserratAlternates-Regular", size: 12))
                            .foregroundColor(Color("error"))
                            Spacer()
                    }
                }
                
                Spacer().frame(height: 24)
                
                Button {
                    submit()
                } label: {
                    PrimaryButton(title: "Получить код")
                        .opacity(!isButtonEnabled ? 0.5 : 1)
                }
                .disabled(!isButtonEnabled)
                
                Spacer()
            }.padding(.horizontal, 16))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: { presentationMode.wrappedValue.dismiss() }, colorPrimary: .white, colorSecondary: Color("orange-secondary")
                    )
                }
            }
            NavigationLink(destination: VerificationCodeView(), isActive: $isLinkActive) {
                EmptyView()
            }
        }
    }
}

#Preview {
    PasswordRecoveryView()
}
