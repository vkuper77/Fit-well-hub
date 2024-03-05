//
//  CreatePasswordScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct CreatePasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = CreatePasswordViewModel()
    
    let email: String
    
    var body: some View {
        NavigationStack {
            MaskScreenView(topComponent: VStack {
                Spacer().frame(height: 40)
                Text("Восстановление пароля")
                    .font(.custom("MontserratAlternates-Bold", size: 24))
                    .foregroundColor(.white)
                Spacer().frame(height: 16)
                Text("Придумайте новый пароль")
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 34)
            }, bottomComponent: VStack {
                Spacer().frame(height: 62)
                
                VStack {
                    SecureInput(value: $viewModel
                        .password, isShowValue: $viewModel.isShowPass, label: "Пароль", placeholder: "Введите пароль...", isShowIcon: true)
                    Spacer().frame(height: 16)
                    SecureInput(value: $viewModel.repeatPassword, isShowValue: $viewModel.isShowPass, label: "Пароль", placeholder: "Повторите пароль...", isShowIcon: false)
                }.onChange(of: viewModel.repeatPassword) {
                    viewModel.errorMessage = ""
                }.onChange(of: viewModel.password) {
                    viewModel.errorMessage = ""
                }
                
                if !viewModel.errorMessage.isEmpty {
                    Spacer().frame(height: 4)
                    HStack {
                        Text(viewModel.errorMessage)
                            .multilineTextAlignment(.leading)
                            .font(.custom("MontserratAlternates-Regular", size: 12))
                            .foregroundColor(.primaryError)
                        Spacer()
                    }
                    .padding(.leading, 16)
                }
                
                Spacer().frame(height: 24)
                
                Button {
                    submit()
                } label: {
                    PrimaryButton(title: "Подтвердить", loading: viewModel.isLoading)
                        .opacity(!viewModel.isButtonEnabled ? 0.5 : 1)
                }
                .disabled(!viewModel.isButtonEnabled || viewModel.isLoading)
                
                Spacer()
            }
                .padding(.horizontal, 16))
            .navigationBarBackButtonHidden(true)
            
            NavigationLink(destination: AuthorizationView(), isActive: $viewModel.isLinkActive) {
                EmptyView()
            }
        }
    }
    
    func submit() {
        Task {
            try await viewModel.submit(email: email)
        }
    }
}

#Preview {
    CreatePasswordView(email: "")
}
