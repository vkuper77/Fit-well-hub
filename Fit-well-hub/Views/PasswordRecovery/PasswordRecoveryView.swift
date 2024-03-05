//
//  PasswordRecoveryScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct PasswordRecoveryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = PasswordRecoveryViewModel()
    
    var body: some View {
        NavigationStack {
            MaskScreenView(topComponent: VStack {
                Spacer().frame(height: 40)
                Text("Восстановление пароля")
                    .font(.custom("MontserratAlternates-Bold", size: 24))
                    .foregroundColor(.white)
                Spacer().frame(height: 16)
                Text("Введите ваш email для получения\nкода на восстановление пароля")
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 34)
            }, bottomComponent: VStack {
                Spacer().frame(height: 62)
                MainInput(value: $viewModel.email, placeholder: "Email", label: "Email")
                    .onChange(of: viewModel.email) { viewModel.errorMessage = ""}
                
                if !viewModel.errorMessage.isEmpty {
                    Spacer().frame(height: 4)
                    HStack {
                        Text(viewModel.errorMessage)
                            .multilineTextAlignment(.leading)
                            .font(.custom("MontserratAlternates-Regular", size: 12))
                            .foregroundColor(.primaryError)
                            Spacer()
                    }
                }
                
                Spacer().frame(height: 24)
                
                Button {
                    sendCode()
                } label: {
                    PrimaryButton(title: "Получить код", loading: viewModel.isLoading)
                        .opacity(!viewModel.isButtonEnabled ? 0.5 : 1)
                }
                .disabled(!viewModel.isButtonEnabled || viewModel.isLoading)
                
                Spacer()
            }.padding(.horizontal, 16))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: { presentationMode.wrappedValue.dismiss() }, colorPrimary: .white, colorSecondary: .secondaryOrange
                    )
                }
            }
            NavigationLink(destination: VerificationCodeView(title: "Восстановление пароля", email: viewModel.email, typeSubmit: "recovery-password"), isActive: $viewModel.isLinkActive) {
                EmptyView()
            }
        }
    }
    
    func sendCode() {
        Task {
            try await viewModel.submit()
        }
    }
}

#Preview {
    PasswordRecoveryView()
}
