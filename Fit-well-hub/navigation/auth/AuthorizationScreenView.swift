//
//  AuthorizationScreen.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.12.23.
//

import SwiftUI

struct AuthorizationScreenView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var login: String = ""
    @State var password: String = ""

    @State var isError: Bool = false
    
    func submit () {
        print("login:", login)
        print("password:", password)
        isError = login != "111" && password != "111"
    }
    
    var isButtonEnabled: Bool {
           return login.count > 0 && password.count > 0
    }
    
    var body: some View {
        VStack {
            VStack {
                Spacer().frame(height: 33)
                MainInput(value: $login, placeholder: "Email или имя пользователя")
                Spacer().frame(height: 12)
                MainInput(value: $password, placeholder: "Пароль")
                Spacer().frame(height: 12)
            }.onChange(of: login) { isError = false }
            .onChange(of: password) { isError = false }
            
            if isError {
                HStack {
                    Text("Неправильный логин или пароль.")
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 16))
                        .foregroundColor(Color("error"))
                    Spacer()
                }
                .padding(.leading, 16)
                Spacer().frame(height: 8)
            }
            
            if isButtonEnabled {
                HStack {
                    Text("Восстановить паролль")
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .underline()
                        .onTapGesture { print("Восстановить паролль") }
                    Spacer()
                }
                .padding(.leading, 16)
                Spacer().frame(height: 21)
            }
            
            Button {
                submit()
            } label: {
                PrimaryButton(title: "Войти")
                    .opacity(!isButtonEnabled ? 0.3 : 1)
            }
            .disabled(!isButtonEnabled)
            
            Spacer()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Авторизация", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CrossButton { presentationMode.wrappedValue.dismiss() }
                }
            }
        }.padding(.horizontal, 16)
    }
}

#Preview {
    AuthorizationScreenView()
}
