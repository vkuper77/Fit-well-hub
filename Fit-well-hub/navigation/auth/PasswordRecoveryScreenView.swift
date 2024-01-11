//
//  PasswordRecoveryScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct PasswordRecoveryScreenView: View {
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
            Spacer().frame(height: 33)
            MainInput(value: $email, placeholder: "Email", label: "Email")
                .onChange(of: email) { isErrorEmail = false}
            if isErrorEmail {
                Spacer().frame(height: 4)
                HStack {
                    Text("Неправильный формат электронной почты. Пожалуйста, проверьте его и попробуйте еще раз")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 12))
                        .foregroundColor(Color("error"))
                        Spacer()
                }
                .padding(.leading, 16)
            }
            Spacer().frame(height: 12)
            Button {
                submit()
            } label: {
                PrimaryButton(title: "Продолжить")
                    .opacity(!isButtonEnabled ? 0.3 : 1)
            }
            .disabled(!isButtonEnabled)
                            
            Spacer()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Восстановление пароля", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton { presentationMode.wrappedValue.dismiss() }
                }
            }
            NavigationLink(destination: VerificationCodeScreenView(), isActive: $isLinkActive) {
                EmptyView()
            }
        }.padding(.horizontal, 16)
    }
}

#Preview {
    PasswordRecoveryScreenView()
}
