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
    
    @State var isShowPass: Bool = false

    @State var isError: Bool = false
    @State var isErrorEmail: Bool = false
    
    func submit () {
        print("login:", login)
        print("password:", password)
        
        if !isValidEmail(login) {
            isErrorEmail = true
        }
        
        isError = login != "111" && password != "111"
    }
    
    var isButtonEnabled: Bool {
           return login.count > 0 && password.count > 0
    }
    
    var body: some View {
        NavigationStack {
            MaskScreenView(topComponent: VStack {
                Spacer().frame(height: 40)
                Text("Авторизация")
                    .font(.custom("MontserratAlternates-Bold", size: 24))
                    .foregroundColor(.white)
                Spacer().frame(height: 16)
                Text("Введите email и пароль\nдля входа в приложение")
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 34)
            }, bottomComponent: VStack {
                Spacer().frame(height: 62)
                
                VStack(spacing: 4) {
                    MainInput(value: $login, placeholder: "Введите email...", label: "Email", isError: isErrorEmail || isError)
                    if isErrorEmail {
                        HStack {
                            Text("Неправильный формат электронной почты.")
                                .multilineTextAlignment(.leading)
                                .font(.custom("MontserratAlternates-Regular", size: 12))
                                .foregroundColor(Color("error"))
                                Spacer()
                        }
                    }
                }.onChange(of: login ) {
                    isErrorEmail = false
                    isError = false
                }
                
                Spacer().frame(height: 16)
                
                VStack(spacing: 8) {
                    SecureInput(value: $password, isShowValue: $isShowPass, label: "Пароль", placeholder: "Введите пароль...", isShowIcon: true, isError: isError)
                    HStack(spacing: .none) {
                        if isError {
                            HStack {
                                Text("Неправильный логин или пароль.")
                                    .multilineTextAlignment(.leading)
                                    .font(.custom("MontserratAlternates-Regular", size: 12))
                                    .foregroundColor(Color("error"))
                                Spacer()
                            }
                        }
                        Spacer()
                        Button{} label: {
                            Text("Забыли пароль?")
                                .font(.custom("MontserratAlternates-SemiBold", size: 12))
                                .foregroundColor(Color("orange-primary"))
                        }
                    }
                }.onChange(of: password ) {
                    isError = false
                }
                
                Spacer().frame(height: 24)
                
                Button {
                    submit()
                } label: {
                    PrimaryButton(title: "Войти")
                        .opacity(!isButtonEnabled ? 0.4 : 1)
                }
                
                Spacer().frame(height: 16)
                
                HStack(spacing: 16) {
                    Text("Ещё нет аккаунта?")
                        .font(.custom("MontserratAlternates-Regular", size: 12))
                        .foregroundColor(Color("orange-primary"))
                    
                    Button{
                        
                    } label: {
                        Text("Зарегистрироваться")
                            .font(.custom("MontserratAlternates-SemiBold", size: 12))
                            .foregroundColor(Color("orange-primary"))
                    }
                }
                
            }.padding(.horizontal, 16))
            
            Spacer()
            
            HStack {
                Rectangle()
                    .fill(Color("grey"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.5)
                Text("Или войти с помощью")
                    .frame(width: 195)
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(Color("grey"))
                Rectangle()
                    .fill(Color("grey"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.5)
            }
            
            HStack(spacing: 16) {
                Button{
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color("grey-light"))
                            .frame(width: 112, height: 59)
                        Image("apple-logo")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                
                Button{
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color("grey-light"))
                            .frame(width: 112, height: 59)
                        Image("google-logo")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .padding(.top, 13)
            .padding(.bottom, 8)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, colorPrimary: .white, colorSecondary: Color("orange-secondary"))
                }
            }
        }
    }
}

#Preview {
    AuthorizationScreenView()
}
