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
            VStack {
                VStack{
                    Spacer().frame(height: 33)
                    
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
                    Spacer().frame(height: 12)
                    SecureInput(value: $pass, isShowValue: $isShowPass, placeholder: "Пароль", isShowIcon: true)
                    Spacer().frame(height: 12)
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
                
                Spacer().frame(height: 12)
                Button {
                    submit()
                } label: {
                    PrimaryButton(title: "Зарегистрироваться")
                        .opacity(!isButtonEnabled ? 0.4 : 1)
                }
                
            }.padding(.horizontal, 16)
            Spacer()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Регистрация", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CrossButton { presentationMode.wrappedValue.dismiss() }
                }
            }
        }
    }
}

#Preview { RegistrationScreenView() }
