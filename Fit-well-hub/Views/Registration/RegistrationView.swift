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
            MaskScreenView(topComponent: RegistrationTopView(), bottomComponent: VStack {
                Spacer().frame(height: 62)
                
                VStack {
                    MainInput(value: $viewModel.email, placeholder: "Введите email...", label: "Email", isError: viewModel.isErrorEmail || !viewModel.errorMessage.isEmpty)
                    RegistrationAccountErrorView(viewModel: viewModel)
                }.onChange(of: viewModel.email ) {
                    viewModel.isErrorEmail = false
                    viewModel.errorMessage = ""
                }.onChange(of: viewModel.pass ) {
                    viewModel.isErrorEmail = false
                    viewModel.errorMessage = ""
                }
                
                VStack(spacing: 16) {
                    SecureInput(value: $viewModel.pass, isShowValue: $viewModel.isShowPass, label: "Пароль", placeholder: "Введите пароль...", isShowIcon: true, isError: viewModel.isErrorPass)
                    SecureInput(value: $viewModel.repeatPass, isShowValue: $viewModel.isShowPass, label: "Пароль", placeholder: "Повторите пароль...", isShowIcon: false, isError: viewModel.isErrorPass)
                }.onChange(of: viewModel.repeatPass) {
                    viewModel.isErrorPass = false
                }.onChange(of: viewModel.pass) {
                    viewModel.isErrorPass = false
                }.padding(.top, 16)
                
                if viewModel.isErrorPass {
                    HStack {
                        Text("Пароли не совпадают")
                            .multilineTextAlignment(.leading)
                            .font(.custom("MontserratAlternates-Regular", size: 12))
                            .foregroundColor(.primaryError)
                        Spacer()
                    }.padding(.top, 4)
                }
                
                Button {
                    submit()
                } label: {
                    PrimaryButton(title: "Зарегистрироваться", loading: viewModel.isLoading)
                }.disabled(!viewModel.isButtonEnabled || viewModel.isLoading)
                    .padding(.bottom, 16)
                    .padding(.top, 24)
                
                ExistingAccountView(isLinkActive: $viewModel.isLinkAuthorizationScreen)
                
            }.padding(.horizontal, 16))
            
            Spacer()
            
            SocialLoginButtons()
                .padding(.top, 13)
                .padding(.bottom, 8)
            
            NavigationLink(destination: AuthorizationView(), isActive: $viewModel.isLinkAuthorizationScreen) {
                EmptyView()
            }
            
            NavigationLink(destination: VerificationCodeView(title: "Подтверждение\nрегистрации", email: viewModel.email, typeSubmit: "registration"), isActive: $viewModel.isLinkActiveCodeScreen) {
                EmptyView()
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func submit() {
        Task {
            do { try await viewModel.submit() }
        }
    }
}

#Preview { RegistrationView() }
