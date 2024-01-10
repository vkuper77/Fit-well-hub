//
//  RegistrationScreen.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.12.23.
//

import SwiftUI

struct RegistrationScreenView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                VStack {
                    Spacer().frame(height: 62)
                    MainInput(value: $email, placeholder: "Email")
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
                    
                    if isErrorUserExist {
                        Spacer().frame(height: 4)
                        HStack {
                            NavigationLink(destination: AuthorizationScreenView()) {
                                Text("Пользователь с таким email уже существует.\nЕсли данный email Ваш -\(Text("войдите в систему").underline(true, color: Color("error")))")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("error"))
                            }
                            Spacer()
                        }
                        .padding(.leading, 16)
                    }
                }.onChange(of: email ) { isErrorEmail = false }
                
                VStack {
                    Spacer().frame(height: 16)
                    SecureInput(value: $pass, isShowValue: $isShowPass, placeholder: "Пароль", isShowIcon: true)
                    Spacer().frame(height: 16)
                    SecureInput(value: $repeatPass, isShowValue: $isShowPass, placeholder: "Повторите пароль", isShowIcon: false)
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
                            .font(.system(size: 12))
                            .foregroundColor(Color("error"))
                            Spacer()
                    }
                    .padding(.leading, 16)
                }
                
                Spacer().frame(height: 24)
                
                Button {
                    submit()
                } label: {
                    PrimaryButton(title: "Зарегистрироваться")
                        .opacity(!isButtonEnabled ? 0.4 : 1)
                }
                
                Spacer().frame(height: 16)
                
                HStack(spacing: 16) {
                    Text("Уже есть аккаунт?")
                        .font(.custom("MontserratAlternates-Regular", size: 12))
                        .foregroundColor(Color("orange-primary"))
                    Text("Авторизироваться")
                        .font(.custom("MontserratAlternates-SemiBold", size: 12))
                        .foregroundColor(Color("orange-primary"))
                }
                
            }.padding(.horizontal, 16))
            
            Spacer()
            
            HStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color("grey"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.5)
                Text("Или войти с помощью")
                    .frame(width: 195)
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(Color("grey"))
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color("grey"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.5)
            }
            
            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color("grey-light"))
                    .frame(width: 112, height: 59)
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color("grey-light"))
                    .frame(width: 112, height: 59)
                    
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

#Preview { RegistrationScreenView() }
