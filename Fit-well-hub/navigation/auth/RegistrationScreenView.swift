//
//  RegistrationScreen.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.12.23.
//

import SwiftUI

struct RegistrationScreenView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLinkActiveCodeScreen: Bool = false
    
    @State var email: String = ""
    
    @State var pass: String = ""
    @State var repeatPass: String = ""
    
    @State var isShowPass: Bool = false
    
    @State var isErrorUserExist: Bool = false
    @State var isErrorEmail: Bool = false
    @State var isErrorPass: Bool = false
    
    var isButtonEnabled: Bool {
           return !pass.isEmpty 
        && !repeatPass.isEmpty
        && !email.isEmpty
        && !isErrorUserExist 
        && !isErrorEmail
        && !isErrorPass
    }
    
    func clear () {
        isErrorUserExist = false
        isErrorEmail = false
        email = ""
    }
    
    func submit () {
        isLinkActiveCodeScreen = true
        
        if !isValidEmail(email) {
            isErrorEmail = true
        }
        
        if pass != repeatPass {
            isErrorPass = true
        }
        
    }
    
    var body: some View {
        NavigationStack {
            MaskScreenView(topComponent: VStack {
                Spacer().frame(height: 40)
                Text("Регистрация")
                    .font(.custom("MontserratAlternates-Bold", size: 24))
                    .foregroundColor(.white)
                Spacer().frame(height: 16)
                Text("Добро пожаловать, дорогой друг,\nв мир заботы о себе!")
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 34)
            }, bottomComponent: VStack {
                Spacer().frame(height: 62)
                
                VStack {
                    MainInput(value: $email, placeholder: "Введите email...", label: "Email", isError: isErrorEmail || isErrorUserExist)
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
                    if isErrorUserExist {
                        Spacer().frame(height: 4)
                        HStack {
                            NavigationLink(destination: AuthorizationScreenView()) {
                                Text("Аккаунт с данным email уже существует")
                                    .multilineTextAlignment(.leading)
                                    .font(.custom("MontserratAlternates-Regular", size: 12))
                                    .foregroundColor(Color("error"))
                            }
                            Spacer()
                        }
                    }
                }.onChange(of: email ) { isErrorEmail = false }
                
                Spacer().frame(height: 16)
                
                VStack(spacing: 16) {
                    SecureInput(value: $pass, isShowValue: $isShowPass, label: "Пароль", placeholder: "Введите пароль...", isShowIcon: true, isError: isErrorPass)
                    SecureInput(value: $repeatPass, isShowValue: $isShowPass, label: "Пароль", placeholder: "Повторите пароль...", isShowIcon: false, isError: isErrorPass)
                }.onChange(of: repeatPass) {
                    isErrorPass = false
                }.onChange(of: pass) {
                    isErrorPass = false
                }
                
                if isErrorPass {
                    Spacer().frame(height: 4)
                    HStack {
                        Text("Пароли не совпадают")
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
                    PrimaryButton(title: "Зарегистрироваться")
                        .opacity(!isButtonEnabled ? 0.5 : 1)
                }
                
                Spacer().frame(height: 16)
                
                HStack(spacing: 16) {
                    Text("Уже есть аккаунт?")
                        .font(.custom("MontserratAlternates-Regular", size: 12))
                        .foregroundColor(Color("orange-primary"))
                    
                    Button{
                        
                    } label: {
                        Text("Авторизироваться")
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
                
                Button {
                    
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
        NavigationLink(destination: VerificationCodeScreenView(), isActive: $isLinkActiveCodeScreen) {
            EmptyView()
        }
    }
}

#Preview { RegistrationScreenView() }
