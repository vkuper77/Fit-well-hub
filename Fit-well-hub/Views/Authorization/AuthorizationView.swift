//
//  AuthorizationScreen.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.12.23.
//

import SwiftUI

struct AuthorizationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var app: AppViewModel
    
    @StateObject var viewModel = AuthorizationViewModel()
    
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
                    MainInput(value: $viewModel.login, placeholder: "Введите email...", label: "Email", isError: viewModel.isErrorEmail || !viewModel.errorMessage.isEmpty)
                    if viewModel.isErrorEmail {
                        HStack {
                            Text("Неправильный формат электронной почты.")
                                .multilineTextAlignment(.leading)
                                .font(.custom("MontserratAlternates-Regular", size: 12))
                                .foregroundColor(.primaryError)
                                Spacer()
                        }
                    }
                }.onChange(of: viewModel.login ) {
                    viewModel.isErrorEmail = false
                    viewModel.errorMessage = ""
                }
                
                Spacer().frame(height: 16)
                
                VStack(spacing: 8) {
                    SecureInput(value: $viewModel.password, isShowValue: $viewModel.isShowPass, label: "Пароль", placeholder: "Введите пароль...", isShowIcon: true, isError: !viewModel.errorMessage.isEmpty)
                    HStack(spacing: .none) {
                        if !viewModel.errorMessage.isEmpty {
                            HStack {
                                Text(viewModel.errorMessage)
                                    .multilineTextAlignment(.leading)
                                    .font(.custom("MontserratAlternates-Regular", size: 12))
                                    .foregroundColor(.primaryError)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                        }
                        Spacer()
                        Button {
                            viewModel.isLinkCreatePasswordScreen = true
                        } label: {
                            Text("Забыли пароль?")
                                .font(.custom("MontserratAlternates-SemiBold", size: 12))
                                .foregroundColor(.primaryOrange)
                        }
                    }
                }.onChange(of: viewModel.password ) {
                    viewModel.errorMessage = ""
                }
                
                Spacer().frame(height: 24)
                
                Button {
                    submit()
                } label: {
                    PrimaryButton(title: "Войти", loading: viewModel.isLoading)
                }.disabled(!viewModel.isButtonEnabled || viewModel.isLoading)
                
                Spacer().frame(height: 16)
                
                HStack(spacing: 16) {
                    Text("Ещё нет аккаунта?")
                        .font(.custom("MontserratAlternates-Regular", size: 12))
                        .foregroundColor(.primaryOrange)
                    
                    Button{
                        viewModel.isLinkRegistrationScreen = true
                    } label: {
                        Text("Зарегистрироваться")
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
                
                Button{
                    
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
            NavigationLink(destination: RegistrationView(), isActive: $viewModel.isLinkRegistrationScreen) {
                EmptyView()
            }
            NavigationLink(destination: PasswordRecoveryView(), isActive: $viewModel.isLinkCreatePasswordScreen) {
                EmptyView()
            }
        }
    }
    
    func submit () {
        Task {
            do {
               try await viewModel.submit()
                app.isAuth = true
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    AuthorizationView()
}
