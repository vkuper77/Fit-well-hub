//
//  RegistrationScreen.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.12.23.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = RegistrationViewModel()
    
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
                    MainInput(value: $viewModel.email, placeholder: "Введите email...", label: "Email", isError: viewModel.isErrorEmail || !viewModel.errorMessage.isEmpty)
                    if viewModel.isErrorEmail {
                        HStack {
                            Text("Неправильный формат электронной почты.")
                                .multilineTextAlignment(.leading)
                                .font(.custom("MontserratAlternates-Regular", size: 12))
                                .foregroundColor(.primaryError)
                                Spacer()
                        }.padding(.top, 4)
                    }
                    if !viewModel.errorMessage.isEmpty {
                        HStack {
                            Text(viewModel.errorMessage)
                                .multilineTextAlignment(.leading)
                                .font(.custom("MontserratAlternates-Regular", size: 12))
                                .foregroundColor(.primaryError)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }.padding(.top, 4)
                    }
                }.onChange(of: viewModel.email ) {
                    viewModel.isErrorEmail = false
                    viewModel.errorMessage = ""
                }.onChange(of: viewModel.pass ) {
                    viewModel.isErrorEmail = false
                    viewModel.errorMessage = ""
                }
                
                Spacer().frame(height: 16)
                
                VStack(spacing: 16) {
                    SecureInput(value: $viewModel.pass, isShowValue: $viewModel.isShowPass, label: "Пароль", placeholder: "Введите пароль...", isShowIcon: true, isError: viewModel.isErrorPass)
                    SecureInput(value: $viewModel.repeatPass, isShowValue: $viewModel.isShowPass, label: "Пароль", placeholder: "Повторите пароль...", isShowIcon: false, isError: viewModel.isErrorPass)
                }.onChange(of: viewModel.repeatPass) {
                    viewModel.isErrorPass = false
                }.onChange(of: viewModel.pass) {
                    viewModel.isErrorPass = false
                }
                
                if viewModel.isErrorPass {
                    Spacer().frame(height: 4)
                    HStack {
                        Text("Пароли не совпадают")
                            .multilineTextAlignment(.leading)
                            .font(.custom("MontserratAlternates-Regular", size: 12))
                            .foregroundColor(.primaryError)
                            Spacer()
                    }
                }
                
                Spacer().frame(height: 24)
                
                Button {
                    viewModel.submit()
                } label: {
                    PrimaryButton(title: "Зарегистрироваться", loading: viewModel.isLoading)
                        .opacity(!viewModel.isButtonEnabled ? 0.5 : 1)
                }.disabled(!viewModel.isButtonEnabled)
                
                Spacer().frame(height: 16)
                
                HStack(spacing: 16) {
                    
                    Text("Уже есть аккаунт?")
                        .font(.custom("MontserratAlternates-Regular", size: 12))
                        .foregroundColor(.primaryOrange)
                    
                    Button {
                        viewModel.isLinkAuthorizationScreen = true
                    } label: {
                        Text("Авторизироваться")
                            .font(.custom("MontserratAlternates-SemiBold", size: 12))
                            .foregroundColor(.primaryOrange)
                    }
                    
                }
                
            }.padding(.horizontal, 16))
            
            Spacer()
            
            HStack {
                Rectangle()
                    .fill(Color.primaryGrey)
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.5)
                Text("Или войти с помощью")
                    .frame(width: 195)
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.primaryGrey)
                Rectangle()
                    .fill(Color.primaryGrey)
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.5)
            }
            
            HStack(spacing: 16) {
                Button{
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.secondaryGrey)
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
                            .fill(Color.secondaryGrey)
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
            
            NavigationLink(destination: AuthorizationView(), isActive: $viewModel.isLinkAuthorizationScreen) {
                EmptyView()
            }
            NavigationLink(destination: VerificationCodeView(title: "Подтверждение\nрегистрации", typeSubmit: "registration"), isActive: $viewModel.isLinkActiveCodeScreen) {
                EmptyView()
            }
        }
    }
}

#Preview { RegistrationView() }
